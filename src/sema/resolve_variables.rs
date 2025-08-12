use std::collections::{HashMap, hash_map::Entry};

use miette::Diagnostic;

use crate::parser::*;

#[derive(Debug, thiserror::Error, Diagnostic)]
pub enum Error {
    #[error("{0} has been declared twice")]
    DuplicateDeclaration(String),
    #[error("{0} used without being declared")]
    UnresolvedReference(String),
    #[error("{0} assigned without being declared")]
    UnresolvedAssignment(String),
    #[error("cannot call non-identifier {0}")]
    NonIdentifierCall(String),
    #[error("cannot assign to non-identifier {0}")]
    NonIdentifierAssignment(String),
    #[error("cannot define {0} inside another function")]
    NestedFunctionDefinition(String),
}

type Result<T = ()> = miette::Result<T, Error>;

#[derive(Default)]
struct Scope {
    vars: Vec<HashMap<String, (String, Linkage)>>,
    idx: u32,
}

impl Scope {
    fn declare(&mut self, name: &str, linkage: Linkage) -> Result<&String> {
        let last = self.vars.last_mut().unwrap();
        let resolved = match last.entry(name.to_string()) {
            Entry::Occupied(occupied_entry) => match linkage {
                Linkage::External if occupied_entry.get().1 == Linkage::External => {
                    occupied_entry.into_mut()
                }
                _ => return Err(Error::DuplicateDeclaration(name.to_string())),
            },
            Entry::Vacant(vacant_entry) => vacant_entry.insert((
                match linkage {
                    Linkage::None => format!("{name}.{}", self.idx),
                    Linkage::External => name.into(),
                },
                linkage,
            )),
        };

        self.idx += 1;

        Ok(&resolved.0)
    }

    fn get(&self, name: &str) -> Option<&String> {
        self.vars
            .iter()
            .rev()
            .find_map(|s| s.get(name))
            .as_ref()
            .map(|(s, _)| s)
    }

    fn nest(&mut self, f: impl FnOnce(&mut Self) -> Result) -> Result {
        self.push();
        f(self)?;
        self.pop();
        Ok(())
    }

    fn push(&mut self) {
        self.vars.push(Default::default())
    }

    fn pop(&mut self) {
        self.vars.pop().unwrap();
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
enum Linkage {
    None,
    External,
}

fn visit_expr(expression: &mut Expression, scope: &mut Scope) -> Result {
    match expression {
        Expression::Unary(op, expression) => match op {
            UnaryOperator::PrefixIncrement
            | UnaryOperator::PrefixDecrement
            | UnaryOperator::PostfixIncrement
            | UnaryOperator::PostfixDecrement => visit_assignment_lhs(expression, scope)?,
            _ => visit_expr(expression, scope)?,
        },
        Expression::Binary(_, lhs, rhs) => {
            visit_expr(lhs, scope)?;
            visit_expr(rhs, scope)?;
        }
        Expression::Var(name) => {
            *name = scope
                .get(name)
                .ok_or_else(|| Error::UnresolvedReference(name.clone()))?
                .clone();
        }
        Expression::Assignment(lhs, rhs) | Expression::CompoundAssignment(lhs, _, rhs) => {
            visit_assignment_lhs(lhs, scope)?;
            visit_expr(rhs, scope)?;
        }
        Expression::Ternary(cond, then, r#else) => {
            visit_expr(cond, scope)?;
            visit_expr(then, scope)?;
            visit_expr(r#else, scope)?;
        }
        Expression::Constant(_) => {}
        Expression::FunctionCall(function, expressions) => {
            visit_expr(function, scope)?;
            match function.as_ref() {
                Expression::Var(var) if scope.get(var).is_some() => {}
                _ => return Err(Error::NonIdentifierCall(format!("{function:?}"))),
            }
            for expr in expressions.iter_mut() {
                visit_expr(expr, scope)?;
            }
        }
    }
    Ok(())
}

fn visit_optional_expression(expression: &mut Option<Expression>, scope: &mut Scope) -> Result {
    expression
        .as_mut()
        .map(|e| visit_expr(e, scope))
        .unwrap_or(Ok(()))
}

fn visit_statement(statement: &mut Statement, scope: &mut Scope) -> Result {
    match statement {
        Statement::Return(expression) | Statement::Expression(expression) => {
            visit_expr(expression, scope)
        }
        Statement::Null | Statement::Goto(_) | Statement::Break(_) | Statement::Continue(_) => {
            Ok(())
        }
        Statement::If(cond, then, r#else) => {
            visit_expr(cond, scope)?;
            visit_statement(then, scope)?;
            if let Some(r#else) = r#else {
                visit_statement(r#else, scope)
            } else {
                Ok(())
            }
        }
        Statement::Labeled(_, statement) | Statement::Default(statement, _) => {
            visit_statement(statement, scope)
        }
        Statement::Compound(block) => scope.nest(|scope| visit_block(block, scope)),
        Statement::While(expression, statement, _) => {
            visit_expr(expression, scope)?;
            visit_statement(statement, scope)
        }
        Statement::DoWhile(statement, expression, _) => {
            visit_statement(statement, scope)?;
            visit_expr(expression, scope)
        }
        Statement::For {
            init,
            condition,
            post,
            body,
            label: _,
        } => scope.nest(|scope| {
            match init {
                ForInit::Decl(variable_declaration) => {
                    visit_variable_decl(variable_declaration, scope)
                }
                ForInit::Expr(expression) => visit_optional_expression(expression, scope),
            }?;
            visit_optional_expression(condition, scope)?;
            visit_optional_expression(post, scope)?;
            visit_statement(body, scope)
        }),
        Statement::Switch(expression, statement, _) | Statement::Case(expression, statement, _) => {
            visit_expr(expression, scope)?;
            visit_statement(statement, scope)
        }
    }
}

fn visit_variable_decl(decl: &mut VariableDeclaration, scope: &mut Scope) -> Result {
    decl.name = scope.declare(&decl.name, Linkage::None)?.clone();
    if let Some(init) = decl.init.as_mut() {
        visit_expr(init, scope)?;
    }
    Ok(())
}

fn visit_block(block: &mut Block, scope: &mut Scope) -> Result {
    for item in block.items.iter_mut() {
        match item {
            BlockItem::Statement(statement) => visit_statement(statement, scope)?,
            BlockItem::Declaration(decl) => visit_decl(decl, scope)?,
        }
    }

    Ok(())
}

fn visit_decl(decl: &mut Declaration, scope: &mut Scope) -> Result {
    match decl {
        Declaration::Variable(decl) => visit_variable_decl(decl, scope),
        Declaration::Function(FunctionDeclaration {
            identifier,
            body,
            params,
        }) => {
            scope.declare(identifier, Linkage::External)?;

            scope.push();
            for param in params.iter_mut() {
                *param = scope.declare(param, Linkage::None)?.clone();
            }
            if let Some(body) = body.as_mut() {
                if scope.vars.len() != 2 {
                    return Err(Error::NestedFunctionDefinition(identifier.clone()));
                }

                visit_block(body, scope)?;
            }
            scope.pop();
            Ok(())
        }
    }
}

fn visit_assignment_lhs(expr: &mut Expression, scope: &mut Scope) -> Result {
    match expr {
        Expression::Var(name) => {
            *name = scope
                .get(name)
                .ok_or_else(|| Error::UnresolvedAssignment(name.clone()))?
                .clone();

            Ok(())
        }
        _ => Err(Error::NonIdentifierAssignment(format!("{expr:?}"))),
    }
}

pub fn run(program: &mut Program) -> Result {
    let mut scope = Scope::default();
    scope.push();
    for decl in program.declarations.iter_mut() {
        visit_decl(decl, &mut scope)?
    }
    scope.pop();
    Ok(())
}
