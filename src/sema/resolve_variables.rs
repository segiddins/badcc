use std::collections::{HashMap, hash_map::Entry};

use miette::{Diagnostic, SourceSpan};

use crate::ast::*;

#[derive(Debug, thiserror::Error, Diagnostic)]
#[error("Failed to resolve identifiers")]
pub enum Error {
    #[error("{0} has been declared twice")]
    DuplicateDeclaration(String),
    #[error("{0} used without being declared")]
    UnresolvedReference(String),
    #[error("{0} assigned without being declared")]
    UnresolvedAssignment(String, #[label("identifier")] SourceSpan),
    #[error("cannot call non-identifier")]
    NonIdentifierCall(#[label("identifier required here")] SourceSpan),
    #[error("cannot assign to non-identifier")]
    NonIdentifierAssignment(#[label("lvalue required here")] SourceSpan),
    #[error("cannot define {0} inside another function")]
    NestedFunctionDefinition(String),
    #[error("cannot declare functions at block scope with static storage specifier")]
    NestedFunctionStorageSpecifier,
    #[error("a variable declared in a for loop header cannot have a storage class")]
    ForInitStorageSpecifier {
        #[label("declaration")]
        span: SourceSpan,
    },
    #[error("a variable declared extern cannot have an initializer")]
    ExternVariableInitializer {
        #[label("here")]
        span: SourceSpan,
    },
    #[error("initializers for static variables must be constant")]
    StaticVariableNonConstantInitializer {
        #[label("expression")]
        span: SourceSpan,
    },
}

type Result<T = ()> = miette::Result<T, Error>;

#[derive(Default)]
struct Scope {
    vars: Vec<HashMap<String, (String, bool, SourceSpan)>>,
    idx: u32,
}

impl Scope {
    fn declare(&mut self, name: &str, linkage: bool, span: SourceSpan) -> Result<&String> {
        let last = self.vars.last_mut().unwrap();
        let resolved = match last.entry(name.to_string()) {
            Entry::Occupied(occupied_entry) => match linkage {
                true if occupied_entry.get().1 => occupied_entry.into_mut(),
                _ => return Err(Error::DuplicateDeclaration(name.to_string())),
            },
            Entry::Vacant(vacant_entry) => vacant_entry.insert((
                match linkage {
                    false => format!("{name}.{}", self.idx),
                    true => name.into(),
                },
                linkage,
                span,
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
            .map(|(s, _, _)| s)
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

    const fn is_file(&self) -> bool {
        self.vars.len() == 1
    }
}

fn visit_expr(expression: &mut Expression, scope: &mut Scope) -> Result {
    match expression {
        Expression::Unary { op, expr, .. } => match op {
            UnaryOperator::PrefixIncrement
            | UnaryOperator::PrefixDecrement
            | UnaryOperator::PostfixIncrement
            | UnaryOperator::PostfixDecrement => visit_assignment_lhs(expr, scope)?,
            _ => visit_expr(expr, scope)?,
        },
        Expression::Binary { lhs, rhs, .. } => {
            visit_expr(lhs, scope)?;
            visit_expr(rhs, scope)?;
        }
        Expression::Var { name, .. } => {
            *name = scope
                .get(name)
                .ok_or_else(|| Error::UnresolvedReference(name.clone()))?
                .clone();
        }
        Expression::Assignment { lhs, rhs, .. }
        | Expression::CompoundAssignment { lhs, rhs, .. } => {
            visit_assignment_lhs(lhs, scope)?;
            visit_expr(rhs, scope)?;
        }
        Expression::Ternary {
            cond,
            if_true,
            if_false,
            ..
        } => {
            visit_expr(cond, scope)?;
            visit_expr(if_true, scope)?;
            visit_expr(if_false, scope)?;
        }
        Expression::Constant { .. } => {}
        Expression::FunctionCall {
            function, params, ..
        } => {
            visit_expr(function, scope)?;
            match function.as_ref() {
                Expression::Var { name, .. } if scope.get(name).is_some() => {}
                expr => return Err(Error::NonIdentifierCall(expr.span())),
            }
            for expr in params.iter_mut() {
                visit_expr(expr, scope)?;
            }
        }
        Expression::Cast { expr, .. } => {
            visit_expr(expr, scope)?;
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
        Statement::Null | Statement::Goto(..) | Statement::Break(..) | Statement::Continue(..) => {
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
        Statement::Labeled(_, statement, _) | Statement::Default(statement, _, _) => {
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
                    if variable_declaration.storage.is_some() {
                        return Err(Error::ForInitStorageSpecifier {
                            span: variable_declaration.span,
                        });
                    }
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
    let storage = decl.storage.or_else(|| {
        if scope.is_file() {
            Some(StorageClass::Static)
        } else {
            None
        }
    });
    let linkage = match storage {
        Some(StorageClass::Extern) => true,
        Some(StorageClass::Static) => scope.is_file(),
        None => false,
    };
    decl.name = scope.declare(&decl.name, linkage, decl.span)?.clone();
    if let Some(init) = decl.init.as_mut() {
        visit_expr(init, scope)?;
        match storage {
            Some(StorageClass::Extern) if !scope.is_file() => {
                return Err(Error::ExternVariableInitializer { span: init.span() });
            }
            Some(StorageClass::Static) if !matches!(init, Expression::Constant { .. }) => {
                return Err(Error::StaticVariableNonConstantInitializer { span: init.span() });
            }
            None if scope.is_file() && !matches!(init, Expression::Constant { .. }) => {
                return Err(Error::StaticVariableNonConstantInitializer { span: init.span() });
            }
            _ => {}
        }
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
            storage,
            span,
            ..
        }) => {
            scope.declare(identifier, true, *span)?;

            let is_file = scope.is_file();

            scope.push();
            for (_, name, span) in params.iter_mut() {
                *name = scope.declare(name, false, *span)?.clone();
            }
            if !is_file {
                if body.is_some() {
                    return Err(Error::NestedFunctionDefinition(identifier.clone()));
                }
                if storage.is_some_and(|s| s == StorageClass::Static) {
                    return Err(Error::NestedFunctionStorageSpecifier);
                }
            }
            if let Some(body) = body.as_mut() {
                visit_block(body, scope)?;
            }
            scope.pop();
            Ok(())
        }
    }
}

fn visit_assignment_lhs(expr: &mut Expression, scope: &mut Scope) -> Result {
    match expr {
        Expression::Var { name, span } => {
            *name = scope
                .get(name)
                .ok_or_else(|| Error::UnresolvedAssignment(name.clone(), *span))?
                .clone();

            Ok(())
        }
        expr => Err(Error::NonIdentifierAssignment(expr.span())),
    }
}

pub fn run(program: &mut Program) -> Result {
    let mut scope = Scope::default();
    scope.push();
    for decl in program.declarations.iter_mut() {
        visit_decl(decl, &mut scope)?
    }
    scope.pop();
    assert!(scope.vars.is_empty());
    Ok(())
}
