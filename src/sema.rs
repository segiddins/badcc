use crate::parser::Program;

mod loop_labels;
mod resolve_variables;
mod statement_labels;
mod type_check;

pub fn validate(program: &mut Program) -> miette::Result<()> {
    resolve_variables::run(program)?;
    type_check::run(program)?;
    statement_labels::run(program)?;
    loop_labels::run(program)
}
