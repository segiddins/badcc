use std::collections::HashSet;

use miette::{Diagnostic, SourceSpan};

use crate::ast::*;

type Result = miette::Result<(), Error>;

#[derive(Debug, thiserror::Error, Diagnostic)]
pub enum Error {
    #[error("label {0} repeated in function")]
    RepeatedLabel(String, #[label("here")] SourceSpan),
    #[error("jump to unknown label {0}")]
    GotoUnknown(String, #[label("here")] SourceSpan),
}

fn visit_block(block: &Block, labels: &mut HashSet<String>, error: bool) -> Result {
    for item in block.items.iter() {
        match item {
            BlockItem::Statement(statement) => visit_statement(statement, labels, error)?,
            BlockItem::Declaration(_) => {}
        }
    }

    Ok(())
}

fn visit_statement(statement: &Statement, labels: &mut HashSet<String>, error: bool) -> Result {
    match statement {
        Statement::Compound(block) => visit_block(block, labels, error)?,
        Statement::Return(_) => {}
        Statement::Expression(_) => {}
        Statement::Null => {}
        Statement::Break(..) => {}
        Statement::Continue(..) => {}
        Statement::If(_, statement, statement1) => {
            visit_statement(statement, labels, error)?;
            if let Some(statement) = statement1 {
                visit_statement(statement, labels, error)?;
            }
        }
        Statement::Labeled(label, statement, span) => {
            if !labels.insert(label.clone()) && !error {
                return Err(Error::RepeatedLabel(label.clone(), *span));
            }
            visit_statement(statement, labels, error)?
        }
        Statement::Goto(label, span) => {
            if !labels.contains(label) && error {
                return Err(Error::GotoUnknown(label.clone(), *span));
            }
        }
        Statement::While(_, statement, _) => visit_statement(statement, labels, error)?,
        Statement::DoWhile(statement, _, _) => visit_statement(statement, labels, error)?,
        Statement::For { body, .. } => visit_statement(body, labels, error)?,
        Statement::Switch(_, cases, _) => visit_statement(cases, labels, error)?,
        Statement::Case(_, statement, _) => visit_statement(statement, labels, error)?,
        Statement::Default(statement, _, _) => visit_statement(statement, labels, error)?,
    }
    Ok(())
}

fn visit_decl(decl: &Declaration) -> Result {
    match decl {
        Declaration::Variable(_) => {}
        Declaration::Function(function_declaration) => {
            let mut labels = HashSet::new();
            if let Some(body) = function_declaration.body.as_ref() {
                visit_block(body, &mut labels, false)?;
                visit_block(body, &mut labels, true)?;
            }
        }
    }
    Ok(())
}

pub fn run(program: &mut Program) -> Result {
    for decl in program.declarations.iter() {
        visit_decl(decl)?;
    }
    Ok(())
}
