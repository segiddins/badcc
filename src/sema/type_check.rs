use std::{
    collections::{HashMap, HashSet, hash_map::Entry},
    ops::{Deref, DerefMut},
};

use miette::Diagnostic;

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
    DuplicateVariableDefinition { name: String },
    #[error("conflicting linkage for {name} -- {expected:?} vs {actual:?}")]
    ConflictingLinkage {
        name: String,
        expected: Linkage,
        actual: Linkage,
    },
}

#[derive(Debug, Clone, Default)]
pub struct SymbolTable(HashMap<String, Symbol>);

impl SymbolTable {
    fn declare(&mut self, name: String, ty: Ty, linkage: Linkage) -> Result {
        match self.0.entry(name.clone()) {
            Entry::Occupied(mut entry) => {
                let e = entry.get_mut();
                e.assert(&ty)?;
                match (e.linkage, linkage) {
                    (Linkage::Static, Linkage::External) => {}

                    (Linkage::None, Linkage::Static)
                    | (Linkage::None, Linkage::External)
                    | (Linkage::Static, Linkage::None)
                    | (Linkage::External, Linkage::None)
                    | (Linkage::External, Linkage::Static) => {
                        return Err(TypeCheckError::ConflictingLinkage {
                            name,
                            expected: e.linkage,
                            actual: linkage,
                        });
                    }

                    (Linkage::Tentative, _) => e.linkage = linkage,
                    _ => {}
                }
            }
            Entry::Vacant(entry) => {
                entry.insert(Symbol { ty, linkage });
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
    defined_idents: HashSet<String>,
}

#[derive(Debug, Clone)]
pub struct Symbol {
    ty: Ty,
    pub linkage: Linkage,
}

impl Symbol {
    fn new(ty: Ty, storage: &Option<StorageClass>, default: Linkage) -> Self {
        let linkage = storage.as_ref().map(|s| (*s).into()).unwrap_or(default);

        Self { ty, linkage }
    }

    fn assert(&self, expected: &Ty) -> miette::Result<&Ty, TypeCheckError> {
        self.ty.assert(expected)
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Linkage {
    None,
    Static,
    External,
    Tentative,
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
        self.symbols.declare(
            decl.name.clone(),
            Ty::Int,
            if decl.init.is_some() {
                decl.storage
                    .map(Into::into)
                    .unwrap_or(if decl.name.contains('.') {
                        Linkage::None
                    } else {
                        Linkage::Static
                    })
            } else {
                Linkage::Tentative
            },
        )?;
        if let Some(expr) = decl.init.as_ref() {
            if !self.defined_idents.insert(decl.name.clone()) {
                return Err(TypeCheckError::DuplicateVariableDefinition {
                    name: decl.name.clone(),
                });
            }
            self.visit_expression(expr)?.assert(&Ty::Int)?;
        }
        Ok(())
    }
    fn visit_function_declaration(&mut self, decl: &FunctionDeclaration) -> Result {
        self.symbols.declare(
            decl.identifier.clone(),
            Ty::Function {
                params: decl.params.len() as u8,
            },
            if decl.storage == Some(StorageClass::Static) {
                Linkage::Static
            } else {
                Linkage::External
            },
        )?;

        for param in decl.params.iter() {
            self.symbols
                .insert(param.clone(), Symbol::new(Ty::Int, &None, Linkage::None));
        }

        if let Some(body) = decl.body.as_ref() {
            if !self.defined_idents.insert(decl.identifier.clone()) {
                return Err(TypeCheckError::DuplicateFunctionDefinition {
                    name: decl.identifier.clone(),
                });
            }
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
