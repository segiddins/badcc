use std::collections::{HashMap, HashSet, hash_map::Entry};

use miette::Diagnostic;

use crate::parser::{
    Block, Declaration, Expression, ForInit, FunctionDeclaration, Program, Statement,
    VariableDeclaration,
};

type Result = miette::Result<(), TypeCheckError>;

#[derive(Debug, thiserror::Error, Diagnostic, PartialEq, Eq)]
enum TypeCheckError {
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
}

#[derive(Debug, Default)]
struct Checker {
    types: HashMap<String, Ty>,
    defined_functions: HashSet<String>,
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
        self.types.insert(decl.name.clone(), Ty::Int);
        if let Some(expr) = decl.init.as_ref() {
            self.visit_expression(expr)?.assert(&Ty::Int)?;
        }
        Ok(())
    }
    fn visit_function_declaration(&mut self, decl: &FunctionDeclaration) -> Result {
        let ty = Ty::Function {
            params: decl.params.len() as u8,
        };
        match self.types.entry(decl.identifier.clone()) {
            Entry::Occupied(entry) => {
                entry.get().assert(&ty)?;
            }
            Entry::Vacant(entry) => {
                entry.insert(ty);
            }
        }

        for param in decl.params.iter() {
            self.types.insert(param.clone(), Ty::Int);
        }

        if let Some(body) = decl.body.as_ref() {
            if !self.defined_functions.insert(decl.identifier.clone()) {
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
            Expression::Var(var) => self.types.get(var).ok_or_else(|| panic!("no var {var}")),
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
            Expression::Parenthesized {
                lparen_span,
                expr,
                rparen_span,
            } => self.visit_expression(expression),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
enum Ty {
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

pub fn run(program: &Program) -> miette::Result<()> {
    Ok(Checker::default().visit_program(program)?)
}
