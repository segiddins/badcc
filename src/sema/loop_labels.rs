use std::collections::HashSet;

use crate::parser::*;

use miette::{Result, bail, miette};

#[derive(Debug, Default)]
struct Scope {
    idx: u32,
    break_labels: Vec<String>,
    continue_labels: Vec<String>,

    cases: Vec<(String, HashSet<Option<i32>>)>,
}

impl Scope {
    fn new_label(&mut self, is_loop: bool) -> String {
        let label = format!("{}.{}", if is_loop { "loop" } else { "switch" }, self.idx);
        self.idx += 1;
        self.break_labels.push(label.clone());
        if is_loop {
            self.continue_labels.push(label.clone());
        } else {
            self.cases.push((label.clone(), Default::default()));
        }
        label
    }

    fn pop(&mut self, is_loop: bool) {
        self.break_labels.pop().unwrap();
        if is_loop {
            self.continue_labels.pop().unwrap();
        } else {
            self.cases.pop().unwrap();
        }
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
            label.replace(loop_label.new_label(true));
            visit_statement(statement, loop_label)?;
            loop_label.pop(true);
        }
        Statement::DoWhile(statement, _, label) => {
            label.replace(loop_label.new_label(true));
            visit_statement(statement, loop_label)?;
            loop_label.pop(true);
        }
        Statement::For { body, label, .. } => {
            label.replace(loop_label.new_label(true));
            visit_statement(body, loop_label)?;
            loop_label.pop(true);
        }
        Statement::Null => {}
        Statement::Break(label) => {
            label.replace(
                loop_label
                    .break_labels
                    .last()
                    .ok_or_else(|| miette!("Break used outside of loop or switch"))?
                    .into(),
            );
        }
        Statement::Continue(label) => {
            label.replace(
                loop_label
                    .continue_labels
                    .last()
                    .ok_or_else(|| miette!("Continue used outside of loop"))?
                    .into(),
            );
        }
        Statement::Switch(_, cases, label) => {
            label.replace(loop_label.new_label(false));
            visit_statement(cases, loop_label)?;
            loop_label.pop(false);
        }
        Statement::Case(expr, statement, label) => {
            let (switch_label, cases) = loop_label
                .cases
                .last_mut()
                .ok_or_else(|| miette!("case statement used outside of switch"))?;
            label.replace(switch_label.clone());
            match expr {
                Expression::Constant(c) => {
                    if !cases.insert(Some(*c)) {
                        bail!("Duplicate case {c} in switch")
                    }
                }
                _ => bail!("Non-constant expression in case"),
            }
            visit_statement(statement, loop_label)?
        }
        Statement::Default(statement, label) => {
            let (switch_label, cases) = loop_label
                .cases
                .last_mut()
                .ok_or_else(|| miette!("case statement used outside of switch"))?;
            if !cases.insert(None) {
                bail!("Duplicate default in switch")
            }
            label.replace(switch_label.clone());
            visit_statement(statement, loop_label)?
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

fn visit_decl(decl: &mut Declaration, scope: &mut Scope) -> Result<()> {
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

pub(super) fn run(program: &mut Program) -> Result<()> {
    for decl in program.declarations.iter_mut() {
        visit_decl(decl, &mut Scope::default())?
    }
    Ok(())
}
