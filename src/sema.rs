use std::collections::{HashMap, HashSet};

use miette::bail;

use crate::parser::*;

pub fn validate(program: &mut Program) -> miette::Result<()> {
    resolve_variables(program)?;
    resolve_labels(program)
}

fn resolve_labels(program: &mut Program) -> miette::Result<()> {
    fn visit_statement(
        statement: &Statement,
        labels: &mut HashSet<String>,
        error: bool,
    ) -> miette::Result<()> {
        match statement {
            Statement::Return(_) => {}
            Statement::Expression(_) => {}
            Statement::Null => {}

            Statement::If(_, statement, statement1) => {
                visit_statement(statement, labels, error)?;
                if let Some(statement) = statement1 {
                    visit_statement(statement, labels, error)?;
                }
            }
            Statement::Labeled(label, statement) => {
                if !labels.insert(label.clone()) && !error {
                    bail!("Label {label} repeated in function")
                }
                visit_statement(statement, labels, error)?
            }
            Statement::Goto(label) => {
                if !labels.contains(label) && error {
                    bail!("Cannot jump to unknown label {label:?}")
                }
            }
        }
        Ok(())
    }
    {
        let function = &program.function;
        let mut labels = HashSet::new();
        for item in function.body.iter() {
            match item {
                BlockItem::Statement(statement) => visit_statement(statement, &mut labels, false)?,
                BlockItem::Declaration(_) => {}
            }
        }
        for item in function.body.iter() {
            match item {
                BlockItem::Statement(statement) => visit_statement(statement, &mut labels, true)?,
                BlockItem::Declaration(_) => {}
            }
        }
    }
    Ok(())
}

fn resolve_variables(program: &mut Program) -> miette::Result<()> {
    let mut vars: HashMap<String, u8> = HashMap::new();
    fn visit_expr(
        expression: &mut Expression,
        vars: &mut HashMap<String, u8>,
    ) -> miette::Result<()> {
        match expression {
            Expression::Unary(op, expression) => {
                visit_expr(expression, vars)?;
                match op {
                    UnaryOperator::PrefixIncrement
                    | UnaryOperator::PrefixDecrement
                    | UnaryOperator::PostfixIncrement
                    | UnaryOperator::PostfixDecrement => {
                        if !matches!(**expression, Expression::Var(_)) {
                            bail!("Cannot assign to a non-lvalue")
                        }
                    }
                    _ => {}
                }
            }
            Expression::Binary(_, lhs, rhs) => {
                visit_expr(lhs, vars)?;
                visit_expr(rhs, vars)?;
            }
            Expression::Var(name) => {
                if !vars.contains_key(name) {
                    bail!("{name} used without being declared")
                }
            }
            Expression::Assignment(lhs, rhs) | Expression::CompoundAssignment(lhs, _, rhs) => {
                visit_expr(rhs, vars)?;
                match **lhs {
                    Expression::Var(ref name) => {
                        if !vars.contains_key(name) {
                            bail!("{name} assigned without being declared")
                        }
                        visit_expr(rhs, vars)?;
                    }
                    _ => {
                        bail!("Cannot assign to non-variable {lhs:?}")
                    }
                }
            }
            Expression::Ternary(cond, then, r#else) => {
                visit_expr(cond, vars)?;
                visit_expr(then, vars)?;
                visit_expr(r#else, vars)?;
            }
            Expression::Constant(_) => {}
        }
        Ok(())
    }

    fn visit_statement(
        statement: &mut Statement,
        vars: &mut HashMap<String, u8>,
    ) -> miette::Result<()> {
        match statement {
            Statement::Return(expression) | Statement::Expression(expression) => {
                visit_expr(expression, vars)
            }
            Statement::Null | Statement::Goto(_) => Ok(()),
            Statement::If(cond, then, r#else) => {
                visit_expr(cond, vars)?;
                visit_statement(then, vars)?;
                if let Some(r#else) = r#else {
                    visit_statement(r#else, vars)
                } else {
                    Ok(())
                }
            }
            Statement::Labeled(_, statement) => visit_statement(statement, vars),
        }
    }

    for item in program.function.body.iter_mut() {
        match item {
            BlockItem::Statement(statement) => visit_statement(statement, &mut vars)?,
            BlockItem::Declaration(variable_declaration) => {
                if vars.contains_key(&variable_declaration.name) {
                    bail!(
                        "duplicate definition of {} in {}",
                        variable_declaration.name,
                        program.function.name
                    )
                }
                vars.insert(variable_declaration.name.clone(), vars.len() as u8);
                if let Some(init) = variable_declaration.init.as_mut() {
                    visit_expr(init, &mut vars)?;
                }
            }
        }
    }
    Ok(())
}
