use std::{
    collections::{HashMap, hash_map::Entry},
    ops::{Deref, DerefMut},
};

use miette::{Diagnostic, SourceSpan};

use crate::parser::{
    Block, Declaration, Expression, ForInit, FunctionDeclaration, Program, Statement, StorageClass,
    VariableDeclaration,
};

type Result = miette::Result<(), TypeCheckError>;

#[derive(Debug, thiserror::Error, Diagnostic, PartialEq, Eq)]
pub enum TypeCheckError {
    #[error("failed to type check -- expected {expected:?}, got {actual:?}")]
    Error { expected: Ty, actual: Ty },
    #[error("calling a non-function {name}")]
    NonFunctionCall { name: String },
    #[error("calling function {name} with {passed} parameters instead of {expected}")]
    FunctionArity {
        name: String,
        passed: usize,
        expected: u8,
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
    fn declare_automatic(&mut self, name: &str, ty: Ty) {
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
        ty: Ty,
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
        ty: Ty,
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

    toplevel: bool,
}

#[derive(Debug, Clone)]
pub struct Symbol {
    ty: Ty,
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
    Some(i32),
    None,
}

impl Initial {
    pub fn value(&self) -> i32 {
        match self {
            Initial::Tentative => 0,
            Initial::Some(v) => *v,
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
    fn visit_program(&mut self, program: &Program) -> Result {
        for decl in program.declarations.iter() {
            self.toplevel = true;
            self.visit_declaration(decl)?
        }
        Ok(())
    }

    fn visit_declaration(&mut self, decl: &Declaration) -> Result {
        match decl {
            Declaration::Variable(variable_declaration) => {
                self.visit_variable_declaration(variable_declaration)
            }
            Declaration::Function(function_declaration) => {
                self.visit_function_declaration(function_declaration)
            }
        }
    }

    fn visit_variable_declaration(&mut self, decl: &VariableDeclaration) -> Result {
        if self.toplevel {
            match decl.storage {
                Some(StorageClass::Extern) => self.symbols.declare_static(
                    &decl.name,
                    Ty::Int,
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
                    Ty::Int,
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
                    Ty::Int,
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
                        Ty::Int,
                        None,
                        Initial::Tentative,
                        decl.span,
                    )?;
                }
                Some(StorageClass::Static) => {
                    let init = match decl.init {
                        Some(Expression::Constant(c)) => Initial::Some(c),
                        None => Initial::Some(0),
                        Some(_) => {
                            todo!("non-constant initializer on static variable {}", decl.name)
                        }
                    };
                    self.symbols.declare_static(
                        &decl.name,
                        Ty::Int,
                        Some(false),
                        init,
                        decl.span,
                    )?;
                }
                None => {
                    self.symbols.declare_automatic(&decl.name, Ty::Int);
                    if let Some(ref expr) = decl.init {
                        self.visit_expression(expr)?.assert(&Ty::Int)?;
                    }
                }
            }
        }

        Ok(())
    }

    fn visit_function_declaration(&mut self, decl: &FunctionDeclaration) -> Result {
        let global = decl.storage.is_none_or(|s| s != StorageClass::Static);
        let defined = decl.body.is_some();

        self.symbols.declare_fn(
            &decl.identifier,
            Ty::Function {
                params: decl.params.len() as u8,
            },
            global,
            defined,
            decl.span,
        )?;

        for param in decl.params.iter() {
            self.symbols.declare_automatic(param, Ty::Int);
        }

        if let Some(body) = decl.body.as_ref() {
            self.toplevel = false;

            self.visit_block(body)?
        }
        Ok(())
    }

    fn visit_block(&mut self, block: &Block) -> Result {
        for item in block.items.iter() {
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

    fn visit_statement(&mut self, statement: &Statement) -> Result {
        match statement {
            Statement::Return(expression) => {
                self.visit_expression(expression)?;
            }
            Statement::Expression(expression) => {
                self.visit_expression(expression)?;
            }
            Statement::If(expression, statement, statement1) => {
                self.visit_expression(expression)?.assert(&Ty::Int)?;
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
            Statement::Switch(expression, statement, _) => {
                self.visit_expression(expression)?.assert(&Ty::Int)?;
                self.visit_statement(statement)?
            }
            Statement::Case(expression, statement, _) => {
                self.visit_expression(expression)?.assert(&Ty::Int)?;
                self.visit_statement(statement)?
            }
            Statement::Default(statement, _) => self.visit_statement(statement)?,
            _ => {}
        }
        Ok(())
    }

    fn visit_expression(&self, expression: &Expression) -> miette::Result<&Ty, TypeCheckError> {
        match expression {
            Expression::Unary(_, expression) => self.visit_expression(expression)?.assert(&Ty::Int),
            Expression::Binary(_, lhs, rhs) => self
                .visit_expression(lhs)?
                .assert(self.visit_expression(rhs)?),
            Expression::Var(var) => self
                .symbols
                .get(var)
                .map(|t| &t.ty)
                .ok_or_else(|| panic!("no var {var}")),
            Expression::Assignment(lhs, rhs) => {
                let rhs = self.visit_expression(rhs)?;
                let lhs = self.visit_expression(lhs)?;
                lhs.assert(rhs)
            }
            Expression::CompoundAssignment(expression, _, expression1) => self
                .visit_expression(expression)?
                .assert(self.visit_expression(expression1)?),
            Expression::Ternary(expression, expression1, expression2) => {
                self.visit_expression(expression)?;
                self.visit_expression(expression1)?
                    .assert(self.visit_expression(expression2)?)
            }
            Expression::FunctionCall(expression, expressions) => {
                fn name(expression: &Expression) -> String {
                    match expression {
                        Expression::Var(name) => name.clone(),
                        _ => unreachable!(),
                    }
                }
                match self.visit_expression(expression)? {
                    Ty::Function { params } => {
                        if *params as usize != expressions.len() {
                            Err(TypeCheckError::FunctionArity {
                                name: name(expression),
                                passed: expressions.len(),
                                expected: *params,
                            })
                        } else {
                            Ok(&Ty::Int)
                        }
                    }
                    _ => Err(TypeCheckError::NonFunctionCall {
                        name: name(expression),
                    }),
                }
            }
            Expression::Constant(_) => Ok(&Ty::Int),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Ty {
    Function { params: u8 },
    Int,
}

impl Ty {
    fn assert(&self, expected: &Ty) -> miette::Result<&Ty, TypeCheckError> {
        if self == expected {
            Ok(self)
        } else {
            Err(TypeCheckError::Error {
                expected: expected.clone(),
                actual: self.clone(),
            })
        }
    }
}

pub fn run(program: &Program) -> miette::Result<SymbolTable, TypeCheckError> {
    let mut checker = Checker::default();
    checker.visit_program(program)?;
    Ok(checker.symbols)
}
