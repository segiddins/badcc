use std::collections::HashMap;

use miette::bail;

use crate::parser::*;

pub fn validate(program: &mut Program) -> miette::Result<()> {
    resolve_variables(program)
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
            Statement::Null => Ok(()),
            Statement::If(cond, then, r#else) => {
                visit_expr(cond, vars)?;
                visit_statement(then, vars)?;
                if let Some(r#else) = r#else {
                    visit_statement(r#else, vars)
                } else {
                    Ok(())
                }
            }
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
