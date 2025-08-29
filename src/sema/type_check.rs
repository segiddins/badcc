use std::{
    collections::{HashMap, hash_map::Entry},
    mem::take,
    ops::{Deref, DerefMut},
};

use miette::{Diagnostic, SourceSpan};

use crate::{
    assembly_gen::Width,
    ast::{
        BinaryOperator, Block, BlockItem, Constant, Declaration, Expression, ForInit,
        FunctionDeclaration, Program, Spanned, Statement, StorageClass, UnaryOperator,
        VariableDeclaration,
    },
};

type Result<T = ()> = miette::Result<T, TypeCheckError>;

#[derive(Debug, thiserror::Error, Diagnostic, PartialEq, Eq)]
pub enum TypeCheckError {
    #[error("failed to type check -- expected {expected:?}, got {actual:?}")]
    Error {
        expected: Type,
        actual: Type,
        #[label("here")]
        span: SourceSpan,

        #[label(collection, "declared here")]
        declarations: Vec<SourceSpan>,
    },
    #[error("expected numeric expression in {position}")]
    NonNumeric {
        actual: Type,
        #[label("is {actual:?}")]
        span: SourceSpan,
        position: &'static str,
    },
    #[error("calling a non-function {name}")]
    NonFunctionCall {
        name: String,
        #[label("is {ty:?}")]
        span: SourceSpan,
        ty: Type,
        #[label(collection, "declared here")]
        old: Vec<SourceSpan>,
    },
    #[error("calling function {name} with {passed} parameters instead of {expected}")]
    FunctionArity {
        name: String,
        passed: usize,
        expected: usize,

        #[label("call site")]
        span: SourceSpan,

        #[label(collection, "declared here")]
        old: Vec<SourceSpan>,
    },
    #[error("duplication definition of function {name}")]
    DuplicateFunctionDefinition {
        name: String,
        #[label(primary, "here")]
        span: SourceSpan,
        #[label(collection, "previously declared here")]
        old: Vec<SourceSpan>,
    },
    #[error("duplication definition of variable {name}")]
    DuplicateVariableDefinition {
        name: String,
        #[label(primary, "here")]
        span: SourceSpan,
        #[label(collection, "previously declared here")]
        old: Vec<SourceSpan>,
    },
    #[error("conflicting linkage for {name} -- {expected:?} vs {actual:?}")]
    ConflictingLinkage {
        name: String,
        expected: Linkage,
        actual: Linkage,

        #[label(primary, "declared as {actual:?}")]
        span: SourceSpan,

        #[label(collection, "previously declared here as {expected:?}")]
        old: Vec<SourceSpan>,
    },
    #[error("initializer on local extern declaration of {name}")]
    InitializerOnLocalExtern {
        name: String,
        #[label("here")]
        span: SourceSpan,
    },
}

#[derive(Debug, Clone, Default)]
pub struct SymbolTable(HashMap<String, Symbol>);

impl SymbolTable {
    fn declare_automatic(&mut self, name: &str, ty: Type) {
        self.insert(
            name.to_string(),
            Symbol {
                ty,
                attributes: SymbolAttributes::Local,
                declarations: vec![],
            },
        );
    }

    fn declare_static(
        &mut self,
        name: &str,
        ty: Type,
        global: Option<bool>,
        init: Initial,
        span: SourceSpan,
    ) -> Result {
        match self.entry(name.to_string()) {
            Entry::Occupied(mut occupied_entry) => {
                let symbol = occupied_entry.get_mut();
                symbol.assert(&ty, span)?;
                match &mut symbol.attributes {
                    SymbolAttributes::Static {
                        init: old_init,
                        global: old_global,
                    } => {
                        match (global, *old_global) {
                            // extern in block scope
                            (None, _) if !matches!(init, Initial::Some(_)) => {}
                            (None, true) => {}
                            (Some(x), y) if x == y => {}
                            (Some(true), false) if !matches!(init, Initial::Some(_)) => {}
                            _ => {
                                return Err(TypeCheckError::ConflictingLinkage {
                                    name: name.to_string(),
                                    expected: if *old_global {
                                        Linkage::External
                                    } else {
                                        Linkage::Static
                                    },
                                    actual: if global != Some(false) {
                                        Linkage::External
                                    } else {
                                        Linkage::Static
                                    },
                                    span,
                                    old: symbol.declarations.clone(),
                                });
                            }
                        }
                        match (&old_init, init) {
                            (Initial::Some(_) | Initial::None, Initial::Tentative)
                            | (Initial::None, Initial::None) => {}
                            (Initial::Tentative, _) | (Initial::None, Initial::Some(_)) => {
                                *old_init = init;
                            }
                            (Initial::Some(_), Initial::Some(_)) => {
                                return Err(TypeCheckError::DuplicateVariableDefinition {
                                    name: name.to_string(),
                                    span,
                                    old: symbol.declarations.clone(),
                                });
                            }
                            _ => {}
                        }
                        symbol.declarations.push(span);
                    }
                    _ => unreachable!(),
                }
            }
            Entry::Vacant(vacant_entry) => {
                vacant_entry.insert(Symbol {
                    ty,
                    attributes: SymbolAttributes::Static {
                        init,
                        global: global.unwrap_or(true),
                    },
                    declarations: vec![span],
                });
            }
        }
        Ok(())
    }

    fn declare_fn(
        &mut self,
        name: &str,
        ty: Type,
        global: bool,
        defined: bool,
        span: SourceSpan,
    ) -> Result {
        match self.entry(name.to_string()) {
            Entry::Occupied(mut occupied_entry) => {
                let symbol = occupied_entry.get_mut();
                symbol.assert(&ty, span)?;
                match &mut symbol.attributes {
                    SymbolAttributes::Function {
                        defined: old_defined,
                        global: old_global,
                        ..
                    } => {
                        if defined && !global && *old_global {
                            return Err(TypeCheckError::ConflictingLinkage {
                                name: name.to_string(),
                                expected: if *old_global {
                                    Linkage::External
                                } else {
                                    Linkage::Static
                                },
                                actual: if global {
                                    Linkage::External
                                } else {
                                    Linkage::Static
                                },
                                span,
                                old: symbol.declarations.clone(),
                            });
                        }
                        if *old_defined && defined {
                            return Err(TypeCheckError::DuplicateFunctionDefinition {
                                span,
                                name: name.to_string(),
                                old: symbol.declarations.clone(),
                            });
                        }
                        *old_defined = *old_defined || defined;
                    }
                    _ => unreachable!(),
                }
                symbol.declarations.push(span);
            }
            Entry::Vacant(vacant_entry) => {
                vacant_entry.insert(Symbol {
                    ty,
                    attributes: SymbolAttributes::Function {
                        defined,
                        global,
                        _stack_frame_size: 0,
                    },
                    declarations: vec![span],
                });
            }
        }

        Ok(())
    }
}

impl Deref for SymbolTable {
    type Target = HashMap<String, Symbol>;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl DerefMut for SymbolTable {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}

#[derive(Debug, Default)]
struct Checker {
    symbols: SymbolTable,
    switches: HashMap<String, Type>,
    return_type: Type,

    toplevel: bool,
}

#[derive(Debug, Clone)]
pub struct Symbol {
    pub ty: Type,
    pub attributes: SymbolAttributes,
    declarations: Vec<SourceSpan>,
}

impl Symbol {
    pub fn is_global(&self) -> bool {
        match self.attributes {
            SymbolAttributes::Function { global, .. } | SymbolAttributes::Static { global, .. } => {
                global
            }
            SymbolAttributes::Local => false,
        }
    }
}

#[derive(Debug, Clone)]
pub enum SymbolAttributes {
    Function {
        defined: bool,
        global: bool,
        _stack_frame_size: i32,
    },
    Static {
        init: Initial,
        global: bool,
    },
    Local,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Initial {
    Tentative,
    Some(Constant),
    None,
}

impl Initial {
    pub fn value(&self) -> i64 {
        match self {
            Initial::Tentative => 0,
            Initial::Some(Constant::Int(v)) => *v as i64,
            Initial::Some(Constant::Long(v)) => *v,
            Initial::Some(Constant::UInt(v)) => *v as i64,
            Initial::Some(Constant::ULong(v)) => *v as i64,
            Initial::None => 0,
        }
    }

    pub fn tentative(&self) -> bool {
        matches!(self, Initial::Tentative)
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Linkage {
    Static,
    External,
}

impl From<StorageClass> for Linkage {
    fn from(value: StorageClass) -> Self {
        match value {
            StorageClass::Static => Linkage::Static,
            StorageClass::Extern => Linkage::External,
        }
    }
}

impl Constant {
    fn cast(&mut self, to: &Type) -> Result {
        use Constant::*;
        use Type as T;
        match (&self, to) {
            (_, T::Function { .. }) => unreachable!(),
            (_, T::Int) => *self = Int(self.as_long() as i32),
            (_, T::UInt) => *self = UInt(self.as_long() as u32),
            (_, T::Long) => *self = Long(self.as_long()),
            (_, T::ULong) => *self = ULong(self.as_long() as u64),
        }
        Ok(())
    }
}

impl Checker {
    fn visit_program(&mut self, program: &mut Program) -> Result {
        for decl in program.declarations.iter_mut() {
            self.toplevel = true;
            self.visit_declaration(decl)?
        }
        Ok(())
    }

    fn visit_declaration(&mut self, decl: &mut Declaration) -> Result {
        match decl {
            Declaration::Variable(variable_declaration) => {
                self.visit_variable_declaration(variable_declaration)
            }
            Declaration::Function(function_declaration) => {
                self.visit_function_declaration(function_declaration)
            }
        }
    }

    fn visit_variable_declaration(&mut self, decl: &mut VariableDeclaration) -> Result {
        if self.toplevel {
            if let Some(init) = decl.init.as_mut() {
                self.make_cast(init, &decl.ty)?;
            }
            match decl.storage {
                Some(StorageClass::Extern) => self.symbols.declare_static(
                    &decl.name,
                    decl.ty.clone(),
                    None,
                    match decl.init {
                        Some(Expression::Constant { constant, .. }) => Initial::Some(constant),
                        None => Initial::Tentative,
                        Some(_) => {
                            todo!("non-constant initializer on global variable {}", decl.name)
                        }
                    },
                    decl.span,
                )?,
                None => self.symbols.declare_static(
                    &decl.name,
                    decl.ty.clone(),
                    Some(true),
                    match decl.init {
                        Some(Expression::Constant { constant, .. }) => Initial::Some(constant),
                        None => Initial::None,
                        Some(_) => {
                            todo!("non-constant initializer on global variable {}", decl.name)
                        }
                    },
                    decl.span,
                )?,
                Some(StorageClass::Static) => self.symbols.declare_static(
                    &decl.name,
                    decl.ty.clone(),
                    Some(false),
                    match decl.init {
                        Some(Expression::Constant { constant, .. }) => Initial::Some(constant),
                        None => Initial::Tentative,
                        Some(_) => {
                            todo!("non-constant initializer on static variable {}", decl.name)
                        }
                    },
                    decl.span,
                )?,
            }
        } else {
            match decl.storage {
                Some(StorageClass::Extern) => {
                    if decl.init.is_some() {
                        return Err(TypeCheckError::InitializerOnLocalExtern {
                            name: decl.name.clone(),
                            span: decl.span,
                        });
                    }

                    self.symbols.declare_static(
                        &decl.name,
                        decl.ty.clone(),
                        None,
                        Initial::Tentative,
                        decl.span,
                    )?;
                }
                Some(StorageClass::Static) => {
                    let init = match decl.init {
                        Some(Expression::Constant { constant, .. }) => Initial::Some(constant),
                        None => Initial::Some(Constant::Int(0)),
                        Some(_) => {
                            todo!("non-constant initializer on static variable {}", decl.name)
                        }
                    };
                    self.symbols.declare_static(
                        &decl.name,
                        decl.ty.clone(),
                        Some(false),
                        init,
                        decl.span,
                    )?;
                }
                None => {
                    self.symbols.declare_automatic(&decl.name, decl.ty.clone());
                    if let Some(expr) = decl.init.as_mut() {
                        self.make_cast(expr, &decl.ty)?;
                    }
                }
            }
        }

        Ok(())
    }

    fn visit_function_declaration(&mut self, decl: &mut FunctionDeclaration) -> Result {
        let global = decl.storage.is_none_or(|s| s != StorageClass::Static);
        let defined = decl.body.is_some();

        self.symbols.declare_fn(
            &decl.identifier,
            Type::Function {
                params: decl.params.iter().map(|(ty, _, _)| ty).cloned().collect(),
                ret: Box::new(decl.ret.clone()),
            },
            global,
            defined,
            decl.span,
        )?;

        for (ty, name, _) in decl.params.iter() {
            self.symbols.declare_automatic(name, ty.clone());
        }

        if let Some(body) = decl.body.as_mut() {
            self.toplevel = false;
            self.return_type = decl.ret.clone();

            self.visit_block(body)?
        }
        Ok(())
    }

    fn visit_block(&mut self, block: &mut Block) -> Result {
        for item in block.items.iter_mut() {
            match item {
                BlockItem::Statement(statement) => self.visit_statement(statement)?,
                BlockItem::Declaration(declaration) => self.visit_declaration(declaration)?,
            }
        }
        Ok(())
    }

    fn visit_statement(&mut self, statement: &mut Statement) -> Result {
        match statement {
            Statement::Return(expression) => {
                self.make_cast(expression, &self.return_type)?;
            }
            Statement::Expression(expression) => {
                self.visit_expression(expression)?;
            }
            Statement::If {
                cond: expression,
                if_true: statement,
                if_false: statement1,
            } => {
                self.visit_numeric_expression(expression, "if condition")?;
                if let Some(statement) = statement1 {
                    self.visit_statement(statement)?;
                }
                self.visit_statement(statement)?
            }
            Statement::Labeled {
                label: _,
                statement,
                span: _,
            } => self.visit_statement(statement)?,
            Statement::Compound(block) => self.visit_block(block)?,
            Statement::While {
                expression,
                statement,
                label: _,
            } => {
                self.visit_numeric_expression(expression, "while loop control condition")?;
                self.visit_statement(statement)?
            }
            Statement::DoWhile {
                statement,
                expression,
                label: _,
            } => {
                self.visit_statement(statement)?;
                self.visit_numeric_expression(expression, "do-while loop control condition")?;
            }
            Statement::For {
                init,
                condition,
                post,
                body,
                ..
            } => {
                match init {
                    ForInit::Decl(variable_declaration) => {
                        self.visit_variable_declaration(variable_declaration)?;
                    }
                    ForInit::Expr(Some(expression)) => {
                        self.visit_expression(expression)?;
                    }
                    ForInit::Expr(None) => {}
                }
                if let Some(expression) = condition {
                    self.visit_numeric_expression(expression, "for loop condition")?;
                }
                if let Some(expression) = post {
                    self.visit_expression(expression)?;
                }
                self.visit_statement(body)?;
            }
            Statement::Switch {
                condition: expression,
                body: statement,
                label,
            } => {
                let ty = self.visit_numeric_expression(
                    expression,
                    "switch statement controlling condition",
                )?;
                self.switches.insert(label.clone().unwrap(), ty.clone());
                self.visit_statement(statement)?
            }
            Statement::Case {
                expression,
                statement,
                label,
            } => {
                self.make_cast(
                    expression,
                    self.switches.get(label.as_ref().unwrap()).unwrap(),
                )?;
                self.visit_statement(statement)?
            }
            Statement::Default {
                statement,
                label: _,
                span: _,
            } => self.visit_statement(statement)?,
            _ => {}
        }
        Ok(())
    }

    fn cast_to_lhs(
        &self,
        lhs: &mut Expression,
        rhs: &mut Expression,
    ) -> miette::Result<Type, TypeCheckError> {
        let lt = self.visit_expression(lhs)?;
        let rt = self.visit_expression(rhs)?;
        self.check_cast(&rt, &lt, rhs.span())?;
        self.make_cast(rhs, &lt)
    }

    fn cast_to_common(
        &self,
        lhs: &mut Expression,
        rhs: &mut Expression,
    ) -> miette::Result<Type, TypeCheckError> {
        let lt = &self.visit_expression(lhs)?;
        let rt = &self.visit_expression(rhs)?;
        self.check_cast(rt, lt, rhs.span())?;

        match (lt, rt) {
            (Type::Function { .. }, _) | (_, Type::Function { .. }) => unreachable!(),

            (Type::Int, Type::Int) => Ok(Type::Int),
            (Type::Long, Type::Long) => Ok(Type::Long),
            (Type::ULong, Type::ULong) => Ok(Type::ULong),
            (Type::UInt, Type::UInt) => Ok(Type::UInt),

            (Type::Int | Type::UInt, Type::Long) => self.make_cast(lhs, rt),
            (Type::Long, Type::Int | Type::UInt) => self.make_cast(rhs, lt),

            (Type::Int, Type::UInt) => self.make_cast(lhs, rt),
            (Type::UInt, Type::Int) => self.make_cast(rhs, lt),

            (Type::Int | Type::UInt | Type::Long, Type::ULong) => self.make_cast(lhs, rt),
            (Type::ULong, Type::Int | Type::UInt | Type::Long) => self.make_cast(rhs, lt),
        }
    }

    fn check_cast(
        &self,
        from: &Type,
        to: &Type,
        span: SourceSpan,
    ) -> miette::Result<(), TypeCheckError> {
        match (from, to) {
            (
                Type::Int | Type::Long | Type::UInt | Type::ULong,
                Type::Int | Type::Long | Type::UInt | Type::ULong,
            ) => Ok(()),
            (actual, to) => Err(TypeCheckError::Error {
                expected: to.clone(),
                actual: actual.clone(),
                span,
                declarations: vec![],
            }),
        }
    }

    fn make_cast(&self, expr: &mut Expression, to: &Type) -> miette::Result<Type, TypeCheckError> {
        match expr {
            Expression::Cast { to: t, .. } if t == to => {
                return Ok(to.clone());
            }
            Expression::Constant { constant, .. } => {
                constant.cast(to)?;
                return Ok(to.clone());
            }
            _ => {}
        }

        let actual = self.visit_expression(expr)?;
        self.check_cast(&actual, to, expr.span())?;
        if actual != *to {
            let span = expr.span();
            *expr = Expression::Cast {
                to: to.clone(),
                expr: Box::new(take(expr)),
                span,
            }
        }
        Ok(to.clone())
    }

    fn visit_expression(
        &self,
        expression: &mut Expression,
    ) -> miette::Result<Type, TypeCheckError> {
        match expression {
            Expression::Unary {
                op: UnaryOperator::Not,
                expr,
                ..
            } => self.visit_numeric_expression(expr, "unary not"),
            Expression::Unary { expr, .. } => {
                self.visit_numeric_expression(expr, "unary expression")
            }
            Expression::Binary {
                op: BinaryOperator::LeftShift | BinaryOperator::RightShift,
                lhs,
                rhs,
                ..
            } => self.cast_to_lhs(lhs, rhs),
            Expression::Binary { lhs, rhs, .. } => self.cast_to_common(lhs, rhs),
            Expression::Var { name, .. } => self
                .symbols
                .get(name)
                .map(|t| t.ty.clone())
                .ok_or_else(|| unreachable!("no var {name}")),
            Expression::Assignment { lhs, rhs, .. } => self.cast_to_lhs(lhs, rhs),
            Expression::CompoundAssignment {
                lhs,
                op: BinaryOperator::LeftShift | BinaryOperator::RightShift,
                rhs,
                ..
            } => self.cast_to_lhs(lhs, rhs),
            Expression::CompoundAssignment { lhs, op, rhs, span } => {
                *expression = Expression::Assignment {
                    lhs: lhs.clone(),
                    rhs: Expression::Binary {
                        op: *op,
                        lhs: lhs.clone(),
                        rhs: rhs.clone(),
                        span: *span,
                    }
                    .into(),
                    span: *span,
                };
                self.visit_expression(expression)
            }
            Expression::Ternary {
                cond,
                if_true,
                if_false,
                ..
            } => {
                self.visit_numeric_expression(cond, "ternary condition")?;
                self.cast_to_common(if_true, if_false)
            }
            Expression::FunctionCall {
                function,
                params: expressions,
                ..
            } => {
                let name = match function.as_ref() {
                    Expression::Var { name, .. } => name.clone(),
                    _ => unreachable!(),
                };
                match self.visit_expression(function)? {
                    Type::Function { params, ret } => {
                        if params.len() != expressions.len() {
                            let old = self.symbols.get(&name).unwrap().declarations.clone();
                            Err(TypeCheckError::FunctionArity {
                                name,
                                passed: expressions.len(),
                                expected: params.len(),
                                span: function.span(),
                                old,
                            })
                        } else {
                            for (expr, ty) in expressions.iter_mut().zip(params) {
                                self.make_cast(expr, &ty)?;
                            }
                            Ok(ret.as_ref().clone())
                        }
                    }
                    ty => {
                        let old = self.symbols.get(&name).unwrap().declarations.clone();
                        Err(TypeCheckError::NonFunctionCall {
                            name,
                            span: function.span(),
                            ty,
                            old,
                        })
                    }
                }
            }
            Expression::Constant { constant, .. } => Ok(constant.ty()),
            Expression::Cast { to, expr, .. } => {
                let actual = self.visit_expression(expr.as_mut())?;
                self.check_cast(&actual, to, expr.span())?;

                if actual == *to {
                    *expression = take(expr.as_mut());
                    Ok(actual)
                } else {
                    Ok(to.clone())
                }
            }
        }
    }

    fn visit_numeric_expression(
        &self,
        expression: &mut Expression,
        position: &'static str,
    ) -> Result<Type> {
        let ty = self.visit_expression(expression)?;
        match ty {
            Type::Function { .. } => Err(TypeCheckError::NonNumeric {
                actual: ty.clone(),
                span: expression.span(),
                position,
            }),
            Type::Int | Type::Long | Type::UInt | Type::ULong => Ok(ty),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, Default)]
pub enum Type {
    Function {
        params: Vec<Type>,
        ret: Box<Type>,
    },
    #[default]
    Int,
    Long,
    UInt,
    ULong,
}

impl Type {
    pub fn width(&self) -> Width {
        match self {
            Type::Function { .. } => Width::Eight,
            Type::Int | Type::UInt => Width::Four,
            Type::Long | Type::ULong => Width::Eight,
        }
    }

    pub fn signed(&self) -> bool {
        match self {
            Type::Function { .. } => false,
            Type::Int | Type::Long => true,
            Type::UInt | Type::ULong => false,
        }
    }
}
impl Symbol {
    fn assert(
        &self,
        expected: &Type,
        spanned: impl Spanned,
    ) -> miette::Result<&Type, TypeCheckError> {
        match (&self.ty, expected) {
            (x, y) if x == y => Ok(x),
            (actual, expected) => Err(TypeCheckError::Error {
                expected: expected.clone(),
                actual: actual.clone(),
                span: spanned.span(),
                declarations: self.declarations.clone(),
            }),
        }
    }
}

pub fn run(program: &mut Program) -> miette::Result<SymbolTable, TypeCheckError> {
    let mut checker = Checker::default();
    checker.visit_program(program)?;
    Ok(checker.symbols)
}
