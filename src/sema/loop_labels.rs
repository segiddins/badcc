use crate::parser::*;

use miette::{Result, miette};

#[derive(Debug, Default)]
struct Scope {
    idx: u32,
    labels: Vec<String>,
}

impl Scope {
    fn new_label(&mut self) -> String {
        let label = format!("loop.{}", self.idx);
        self.idx += 1;
        self.labels.push(label.clone());
        label
    }

    fn pop(&mut self) {
        self.labels.pop().unwrap();
    }
}

fn visit_statement(statement: &mut Statement, loop_label: &mut Scope) -> Result<()> {
    match statement {
        Statement::Return(_) => {}
        Statement::Expression(_) => {}
        Statement::If(_, statement, statement1) => {
            visit_statement(statement, loop_label)?;
            if let Some(statement) = statement1 {
                visit_statement(statement, loop_label)?
            }
        }
        Statement::Labeled(_, statement) => visit_statement(statement, loop_label)?,
        Statement::Goto(_) => {}
        Statement::Compound(block) => visit_block(block, loop_label)?,

        Statement::While(_, statement, label) => {
            label.replace(loop_label.new_label());
            visit_statement(statement, loop_label)?;
            loop_label.pop();
        }
        Statement::DoWhile(statement, _, label) => {
            label.replace(loop_label.new_label());
            visit_statement(statement, loop_label)?;
            loop_label.pop();
        }
        Statement::For { body, label, .. } => {
            label.replace(loop_label.new_label());
            visit_statement(body, loop_label)?;
            loop_label.pop();
        }
        Statement::Null => {}

        Statement::Break(label) => {
            label.replace(
                loop_label
                    .labels
                    .last()
                    .ok_or_else(|| miette!("Break used outside of loop"))?
                    .into(),
            );
        }
        Statement::Continue(label) => {
            label.replace(
                loop_label
                    .labels
                    .last()
                    .ok_or_else(|| miette!("Continue used outside of loop"))?
                    .into(),
            );
        }
    }
    Ok(())
}

fn visit_block(block: &mut Block, scope: &mut Scope) -> Result<(), miette::Error> {
    for item in block.items.iter_mut() {
        match item {
            BlockItem::Statement(statement) => visit_statement(statement, scope)?,
            BlockItem::Declaration(_) => {}
        }
    }
    Ok(())
}

pub(super) fn run(program: &mut Program) -> Result<()> {
    let function = &mut program.function;

    visit_block(&mut function.body, &mut Scope::default())
}
