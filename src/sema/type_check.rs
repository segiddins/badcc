use std::{
    collections::{HashMap, hash_map::Entry},
    mem::swap,
    ops::{Deref, DerefMut},
};

use miette::{Diagnostic, SourceSpan};

use crate::{
    assembly_gen::Width,
    parser::{
        BinaryOperator, Block, Constant, Declaration, Expression, ForInit, FunctionDeclaration,
        Program, Statement, StorageClass, UnaryOperator, VariableDeclaration,
    },
};

type Result = miette::Result<(), TypeCheckError>;

#[derive(Debug, thiserror::Error, Diagnostic, PartialEq, Eq)]
pub enum TypeCheckError {
    #[error("failed to type check -- expected {expected:?}, got {actual:?}")]
    Error { expected: Type, actual: Type },
    #[error("calling a non-function {name}")]
    NonFunctionCall { name: String },
    #[error("calling function {name} with {passed} parameters instead of {expected}")]
    FunctionArity {
        name: String,
        passed: usize,
        expected: usize,
    },
    #[error("duplication definition of function {name}")]
    DuplicateFunctionDefinition { name: String },
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
                symbol.ty.assert(&ty)?;
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
                symbol.ty.assert(&ty)?;
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
                                name: name.to_string(),
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
                        Some(Expression::Constant(c)) => Initial::Some(c),
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
                        Some(Expression::Constant(c)) => Initial::Some(c),
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
                        Some(Expression::Constant(c)) => Initial::Some(c),
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
                        Some(Expression::Constant(c)) => Initial::Some(c),
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
                params: decl.params.iter().map(|(ty, _)| ty).cloned().collect(),
                ret: Box::new(decl.ret.clone()),
            },
            global,
            defined,
            decl.span,
        )?;

        for (ty, name) in decl.params.iter() {
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
                crate::parser::BlockItem::Statement(statement) => {
                    self.visit_statement(statement)?
                }
                crate::parser::BlockItem::Declaration(declaration) => {
                    self.visit_declaration(declaration)?
                }
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
            Statement::If(expression, statement, statement1) => {
                self.visit_expression(expression)?
                    .assert_compatible(&Type::Int)?;
                if let Some(statement) = statement1 {
                    self.visit_statement(statement)?;
                }
                self.visit_statement(statement)?
            }
            Statement::Labeled(_, statement) => self.visit_statement(statement)?,
            Statement::Compound(block) => self.visit_block(block)?,
            Statement::While(expression, statement, _) => {
                self.visit_expression(expression)?;
                self.visit_statement(statement)?
            }
            Statement::DoWhile(statement, expression, _) => {
                self.visit_statement(statement)?;
                self.visit_expression(expression)?;
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
                    self.visit_expression(expression)?;
                }
                if let Some(expression) = post {
                    self.visit_expression(expression)?;
                }
                self.visit_statement(body)?;
            }
            Statement::Switch(expression, statement, label) => {
                let ty = self
                    .visit_expression(expression)?
                    .assert_compatible(&Type::Int)?;
                self.switches.insert(label.clone().unwrap(), ty.clone());
                self.visit_statement(statement)?
            }
            Statement::Case(expression, statement, label) => {
                self.make_cast(
                    expression,
                    self.switches.get(label.as_ref().unwrap()).unwrap(),
                )?;
                self.visit_statement(statement)?
            }
            Statement::Default(statement, _) => self.visit_statement(statement)?,
            _ => {}
        }
        Ok(())
    }

    fn cast_to_lhs<'a>(
        &'a self,
        lhs: &'a mut Expression,
        rhs: &'a mut Expression,
    ) -> miette::Result<&'a Type, TypeCheckError> {
        let lt = self.visit_expression(lhs)?;
        let rt = self.visit_expression(rhs)?;

        match (lt, rt) {
            (lt, rt) if lt == rt => Ok(lt),
            (Type::Int, Type::Long) => self.make_cast(rhs, lt),
            (Type::Long, Type::Int) => self.make_cast(rhs, lt),
            _ => todo!("cast to lhs {lt:?} {rt:?}"),
        }
    }

    fn cast_to_common<'a>(
        &'a self,
        lhs: &'a mut Expression,
        rhs: &'a mut Expression,
    ) -> miette::Result<&'a Type, TypeCheckError> {
        let lt = self.visit_expression(lhs)?;
        let rt = self.visit_expression(rhs)?;

        match (lt, rt) {
            (Type::Int, Type::Int) => Ok(&Type::Int),
            (Type::Long, Type::Long) => Ok(&Type::Long),
            (Type::Int, Type::Long) => self.make_cast(lhs, &Type::Long),
            (Type::Long, Type::Int) => self.make_cast(rhs, &Type::Long),
            _ => todo!("cast to lhs {lt:?} {rt:?}"),
        }
    }

    fn make_cast<'a>(
        &'a self,
        expr: &'a mut Expression,
        to: &'a Type,
    ) -> miette::Result<&'a Type, TypeCheckError> {
        if let Expression::Constant(c) = expr {
            match (&c, to) {
                (Constant::Int(_), Type::Int) | (Constant::Long(_), Type::Long) => {}
                (Constant::Int(i), Type::Long) => *c = Constant::Long(*i as i64),
                (Constant::Long(l), Type::Int) => *c = Constant::Int(*l as i32),
                _ => unreachable!(),
            }
            return Ok(to);
        }

        match expr {
            Expression::Cast(t, _) if t == to => {
                return Ok(to);
            }
            _ => {}
        }

        let mut nested = Expression::Constant(Constant::Int(0));
        swap(&mut nested, expr);
        let from = self.visit_expression(&mut nested)?.clone();
        if &from == to {
            *expr = nested;
        } else {
            *expr = Expression::Cast(to.clone(), nested.into());
        }
        Ok(to)
    }

    fn visit_expression<'a>(
        &'a self,
        expression: &'a mut Expression,
    ) -> miette::Result<&'a Type, TypeCheckError> {
        match expression {
            Expression::Unary(UnaryOperator::Not, expression) => {
                Type::Int.assert_compatible(self.visit_expression(expression)?)
            }
            Expression::Unary(_, expression) => self
                .visit_expression(expression)?
                .assert_compatible(&Type::Int),
            Expression::Binary(
                BinaryOperator::LeftShift | BinaryOperator::RightShift,
                lhs,
                rhs,
            ) => self.cast_to_lhs(lhs, rhs),
            Expression::Binary(_, lhs, rhs) => self.cast_to_common(lhs, rhs),
            Expression::Var(var) => self
                .symbols
                .get(var)
                .map(|t| &t.ty)
                .ok_or_else(|| panic!("no var {var}")),
            Expression::Assignment(lhs, rhs) => self.cast_to_lhs(lhs, rhs),
            Expression::CompoundAssignment(
                lhs,
                BinaryOperator::LeftShift | BinaryOperator::RightShift,
                rhs,
            ) => self.cast_to_lhs(lhs, rhs),
            Expression::CompoundAssignment(lhs, op, rhs) => {
                *expression = Expression::Assignment(
                    lhs.clone(),
                    Expression::Binary(*op, lhs.clone(), rhs.clone()).into(),
                );
                self.visit_expression(expression)
            }
            Expression::Ternary(expression, expression1, expression2) => {
                self.visit_expression(expression)?;
                self.visit_expression(expression1)?
                    .assert_compatible(self.visit_expression(expression2)?)
            }
            Expression::FunctionCall(expression, expressions) => {
                let name = match expression.as_ref() {
                    Expression::Var(name) => name.clone(),
                    _ => unreachable!(),
                };
                match self.visit_expression(expression)? {
                    Type::Function { params, ret } => {
                        if params.len() != expressions.len() {
                            Err(TypeCheckError::FunctionArity {
                                name,
                                passed: expressions.len(),
                                expected: params.len(),
                            })
                        } else {
                            for (expr, ty) in expressions.iter_mut().zip(params) {
                                self.make_cast(expr, ty)?;
                            }
                            Ok(ret)
                        }
                    }
                    _ => Err(TypeCheckError::NonFunctionCall { name }),
                }
            }
            Expression::Constant(c) => Ok(c.ty()),
            Expression::Cast(ty, expr) => ty.assert_compatible(self.visit_expression(expr)?),
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
}

impl Type {
    pub fn width(&self) -> Width {
        match self {
            Type::Function { .. } => Width::Eight,
            Type::Int => Width::Four,
            Type::Long => Width::Eight,
        }
    }

    fn assert(&self, expected: &Type) -> miette::Result<&Type, TypeCheckError> {
        match (self, expected) {
            (x, y) if x == y => Ok(self),
            (Type::Int | Type::Long, Type::Int | Type::Long) => panic!(),
            _ => Err(TypeCheckError::Error {
                expected: expected.clone(),
                actual: self.clone(),
            }),
        }
    }

    fn assert_compatible(&self, expected: &Type) -> miette::Result<&Type, TypeCheckError> {
        match (self, expected) {
            (x, y) if x == y => Ok(self),
            (Type::Int | Type::Long, Type::Int | Type::Long) => Ok(self),
            _ => Err(TypeCheckError::Error {
                expected: expected.clone(),
                actual: self.clone(),
            }),
        }
    }
}

pub fn run(program: &mut Program) -> miette::Result<SymbolTable, TypeCheckError> {
    let mut checker = Checker::default();
    checker.visit_program(program)?;
    Ok(checker.symbols)
}
