use std::{
    collections::{HashMap, HashSet},
    ops::DerefMut,
};

use miette::{bail, miette};

use crate::parser::*;

mod loop_labels;

pub fn validate(program: &mut Program) -> miette::Result<()> {
    resolve_variables(program)?;
    resolve_labels(program)?;
    loop_labels::run(program)
}

fn resolve_labels(program: &mut Program) -> miette::Result<()> {
    fn visit_block(block: &Block, labels: &mut HashSet<String>, error: bool) -> miette::Result<()> {
        for item in block.items.iter() {
            match item {
                BlockItem::Statement(statement) => visit_statement(statement, labels, error)?,
                BlockItem::Declaration(_) => {}
            }
        }

        Ok(())
    }
    fn visit_statement(
        statement: &Statement,
        labels: &mut HashSet<String>,
        error: bool,
    ) -> miette::Result<()> {
        match statement {
            Statement::Compound(block) => visit_block(block, labels, error)?,
            Statement::Return(_) => {}
            Statement::Expression(_) => {}
            Statement::Null => {}
            Statement::Break(_) => {}
            Statement::Continue(_) => {}
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
            Statement::While(_, statement, _) => visit_statement(statement, labels, error)?,
            Statement::DoWhile(statement, _, _) => visit_statement(statement, labels, error)?,
            Statement::For { body, .. } => visit_statement(body, labels, error)?,
        }
        Ok(())
    }
    {
        let function = &program.function;
        let mut labels = HashSet::new();

        visit_block(&function.body, &mut labels, false)?;
        visit_block(&function.body, &mut labels, true)?;
    }
    Ok(())
}

fn resolve_variables(program: &mut Program) -> miette::Result<()> {
    #[derive(Default)]
    struct Scope {
        vars: Vec<HashMap<String, String>>,
        idx: u32,
    }

    impl Scope {
        fn declare(&mut self, name: &str) -> miette::Result<&String> {
            if self.vars.last().unwrap().contains_key(name) {
                bail!("duplicate definition of {}", name)
            }

            let unique = self
                .vars
                .last_mut()
                .unwrap()
                .entry(name.to_string())
                .or_insert(format!("{name}.{}", self.idx));

            self.idx += 1;

            Ok(unique)
        }

        fn get(&self, name: &str) -> Option<&String> {
            self.vars.iter().rev().find_map(|s| s.get(name))
        }

        fn nest(&mut self, f: impl FnOnce(&mut Self) -> miette::Result<()>) -> miette::Result<()> {
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

    fn visit_expr(expression: &mut Expression, scope: &mut Scope) -> miette::Result<()> {
        match expression {
            Expression::Unary(op, expression) => {
                visit_expr(expression, scope)?;
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
                visit_expr(lhs, scope)?;
                visit_expr(rhs, scope)?;
            }
            Expression::Var(name) => {
                *name = scope
                    .get(name)
                    .ok_or_else(|| miette!("{name} used without being declared"))?
                    .clone();
            }
            Expression::Assignment(lhs, rhs) | Expression::CompoundAssignment(lhs, _, rhs) => {
                match lhs.deref_mut() {
                    Expression::Var(name) => {
                        *name = scope
                            .get(name)
                            .ok_or_else(|| miette!("{name} assigned without being declared"))?
                            .into();
                    }
                    _ => {
                        bail!("Cannot assign to non-variable {lhs:?}")
                    }
                }
                visit_expr(rhs, scope)?;
            }
            Expression::Ternary(cond, then, r#else) => {
                visit_expr(cond, scope)?;
                visit_expr(then, scope)?;
                visit_expr(r#else, scope)?;
            }
            Expression::Constant(_) => {}
        }
        Ok(())
    }

    fn visit_optional_expression(
        expression: &mut Option<Expression>,
        scope: &mut Scope,
    ) -> miette::Result<()> {
        expression
            .as_mut()
            .map(|e| visit_expr(e, scope))
            .unwrap_or(Ok(()))
    }

    fn visit_statement(statement: &mut Statement, scope: &mut Scope) -> miette::Result<()> {
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
            Statement::Labeled(_, statement) => visit_statement(statement, scope),
            Statement::Compound(block) => visit_block(block, scope),

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
        }
    }

    fn visit_variable_decl(
        decl: &mut VariableDeclaration,
        scope: &mut Scope,
    ) -> miette::Result<()> {
        decl.name = scope.declare(&decl.name)?.clone();
        if let Some(init) = decl.init.as_mut() {
            visit_expr(init, scope)?;
        }
        Ok(())
    }

    fn visit_block(block: &mut Block, scope: &mut Scope) -> miette::Result<()> {
        scope.nest(|scope| {
            for item in block.items.iter_mut() {
                match item {
                    BlockItem::Statement(statement) => visit_statement(statement, scope)?,
                    BlockItem::Declaration(variable_declaration) => {
                        visit_variable_decl(variable_declaration, scope)?
                    }
                }
            }
            Ok(())
        })
    }

    visit_block(&mut program.function.body, &mut Scope::default())
}
