use std::{collections::HashMap, mem::take};

use miette::SourceSpan;

use crate::ast::*;

#[derive(Debug, thiserror::Error, miette::Diagnostic)]
pub enum Error {
    #[error("Duplicate case {value} in switch")]
    DuplicateCase {
        value: i64,
        #[label(primary, "here")]
        span: SourceSpan,

        #[label("previously")]
        previous: SourceSpan,
    },
    #[error("Duplicate default in switch")]
    DuplicateDefault {
        #[label(primary, "here")]
        span: SourceSpan,

        #[label("previously")]
        previous: SourceSpan,
    },
}

type Result = std::result::Result<(), Error>;

#[derive(Debug, Default)]
struct Scope {
    cases: HashMap<Option<i64>, SourceSpan>,
}

impl Scope {}

fn visit_statement(statement: &mut Statement, scope: &mut Scope) -> Result {
    match statement {
        Statement::Return(_) => {}
        Statement::Expression(_) => {}
        Statement::If {
            cond: _,
            if_true: statement,
            if_false: statement1,
        } => {
            visit_statement(statement, scope)?;
            if let Some(statement) = statement1 {
                visit_statement(statement, scope)?
            }
        }
        Statement::Labeled {
            label: _,
            statement,
            span: _,
        } => visit_statement(statement, scope)?,
        Statement::Goto { label: _, span: _ } => {}
        Statement::Compound(block) => visit_block(block, scope)?,
        Statement::While { statement, .. } => {
            visit_statement(statement, scope)?;
        }
        Statement::DoWhile {
            statement,
            expression: _,
            label: _,
        } => {
            visit_statement(statement, scope)?;
        }
        Statement::For { body, .. } => {
            visit_statement(body, scope)?;
        }
        Statement::Null => {}
        Statement::Break { .. } => {}
        Statement::Continue { .. } => {}
        Statement::Switch {
            body: statement, ..
        } => {
            let cases = take(&mut scope.cases);
            visit_statement(statement, scope)?;
            scope.cases = cases;
        }
        Statement::Case {
            expression: expr,
            statement,
            ..
        } => {
            if let Expression::Constant { constant, span } = expr
                && let Some(previous) = scope.cases.insert(Some(constant.as_long()), *span)
            {
                return Err(Error::DuplicateCase {
                    value: constant.as_long(),
                    span: *span,
                    previous,
                });
            }
            visit_statement(statement, scope)?
        }
        Statement::Default {
            statement, span, ..
        } => {
            if let Some(previous) = scope.cases.insert(None, *span) {
                return Err(Error::DuplicateDefault {
                    span: *span,
                    previous,
                });
            }
            visit_statement(statement, scope)?
        }
    }
    Ok(())
}

fn visit_block(block: &mut Block, scope: &mut Scope) -> Result {
    for item in block.items.iter_mut() {
        match item {
            BlockItem::Statement(statement) => visit_statement(statement, scope)?,
            BlockItem::Declaration(_) => {}
        }
    }
    Ok(())
}

fn visit_decl(decl: &mut Declaration, scope: &mut Scope) -> Result {
    match decl {
        Declaration::Variable(_) => Ok(()),
        Declaration::Function(function_declaration) => {
            if let Some(block) = function_declaration.body.as_mut() {
                visit_block(block, scope)?;
            }
            Ok(())
        }
    }
}

pub(super) fn run(program: &mut Program) -> Result {
    for decl in program.declarations.iter_mut() {
        visit_decl(decl, &mut Scope::default())?
    }
    Ok(())
}
