use miette::Diagnostic;

use crate::ast::Program;

pub use type_check::{Symbol, SymbolAttributes, SymbolTable, Type};

mod loop_labels;
mod resolve_variables;
mod statement_labels;
mod type_check;

#[derive(Debug, thiserror::Error, Diagnostic)]
#[diagnostic(transparent)]
pub enum SemaError {
    #[error(transparent)]
    ResolveVariables(#[from] resolve_variables::Error),
    #[error(transparent)]
    TypeCheck(#[from] type_check::TypeCheckError),
    #[error(transparent)]
    StatementLabels(#[from] statement_labels::Error),
    #[error(transparent)]
    LoopLabels(#[from] loop_labels::Error),
}

pub fn validate(program: &mut Program) -> Result<SymbolTable, SemaError> {
    resolve_variables::run(program)?;
    statement_labels::run(program)?;
    loop_labels::run(program)?;
    Ok(type_check::run(program)?)
}
