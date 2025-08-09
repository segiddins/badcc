use std::collections::{HashMap, HashSet, hash_map::Entry};

use miette::{bail, miette};

use crate::parser::*;

mod loop_labels;
mod type_check;

pub fn validate(program: &mut Program) -> miette::Result<()> {
    resolve_variables(program)?;
    type_check::run(program)?;
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
            Statement::Switch(_, cases, _) => visit_statement(cases, labels, error)?,
            Statement::Case(_, statement, _) => visit_statement(statement, labels, error)?,
            Statement::Default(statement, _) => visit_statement(statement, labels, error)?,
        }
        Ok(())
    }
    for decl in program.declarations.iter() {
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
    }
    Ok(())
}

fn resolve_variables(program: &mut Program) -> miette::Result<()> {
    #[derive(Default)]
    struct Scope {
        vars: Vec<HashMap<String, (String, Linkage)>>,
        idx: u32,
    }

    #[derive(Debug, PartialEq, Eq, Clone, Copy)]
    enum Linkage {
        None,
        External,
    }

    impl Scope {
        fn declare(&mut self, name: &str, linkage: Linkage) -> miette::Result<&String> {
            let last = self.vars.last_mut().unwrap();
            let resolved = match last.entry(name.to_string()) {
                Entry::Occupied(occupied_entry) => match linkage {
                    Linkage::External if occupied_entry.get().1 == Linkage::External => {
                        occupied_entry.into_mut()
                    }
                    _ => bail!("duplicate declaration of {name}"),
                },
                Entry::Vacant(vacant_entry) => vacant_entry.insert((
                    match linkage {
                        Linkage::None => format!("{name}.{}", self.idx),
                        Linkage::External => name.into(),
                    },
                    linkage,
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
                .map(|(s, _)| s)
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
            Expression::Unary(op, expression) => match op {
                UnaryOperator::PrefixIncrement
                | UnaryOperator::PrefixDecrement
                | UnaryOperator::PostfixIncrement
                | UnaryOperator::PostfixDecrement => visit_assignment_lhs(expression, scope)?,
                _ => visit_expr(expression, scope)?,
            },
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
                visit_assignment_lhs(lhs, scope)?;
                visit_expr(rhs, scope)?;
            }
            Expression::Ternary(cond, then, r#else) => {
                visit_expr(cond, scope)?;
                visit_expr(then, scope)?;
                visit_expr(r#else, scope)?;
            }
            Expression::Constant(_) => {}
            Expression::FunctionCall(function, expressions) => {
                visit_expr(function, scope)?;
                match function.as_ref() {
                    Expression::Var(var) if scope.get(var).is_some() => {}
                    _ => bail!("Cannot call non-function {function:?}"),
                }
                for expr in expressions.iter_mut() {
                    visit_expr(expr, scope)?;
                }
            }
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
            Statement::Labeled(_, statement) | Statement::Default(statement, _) => {
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
                        visit_variable_decl(variable_declaration, scope)
                    }
                    ForInit::Expr(expression) => visit_optional_expression(expression, scope),
                }?;
                visit_optional_expression(condition, scope)?;
                visit_optional_expression(post, scope)?;
                visit_statement(body, scope)
            }),
            Statement::Switch(expression, statement, _)
            | Statement::Case(expression, statement, _) => {
                visit_expr(expression, scope)?;
                visit_statement(statement, scope)
            }
        }
    }

    fn visit_variable_decl(
        decl: &mut VariableDeclaration,
        scope: &mut Scope,
    ) -> miette::Result<()> {
        decl.name = scope.declare(&decl.name, Linkage::None)?.clone();
        if let Some(init) = decl.init.as_mut() {
            visit_expr(init, scope)?;
        }
        Ok(())
    }

    fn visit_block(block: &mut Block, scope: &mut Scope) -> miette::Result<()> {
        for item in block.items.iter_mut() {
            match item {
                BlockItem::Statement(statement) => visit_statement(statement, scope)?,
                BlockItem::Declaration(decl) => visit_decl(decl, scope)?,
            }
        }

        Ok(())
    }

    fn visit_decl(decl: &mut Declaration, scope: &mut Scope) -> miette::Result<()> {
        match decl {
            Declaration::Variable(decl) => visit_variable_decl(decl, scope),
            Declaration::Function(FunctionDeclaration {
                identifier,
                body,
                params,
            }) => {
                scope.declare(identifier, Linkage::External)?;

                scope.push();
                for param in params.iter_mut() {
                    *param = scope.declare(param, Linkage::None)?.clone();
                }
                if let Some(body) = body.as_mut() {
                    if scope.vars.len() != 2 {
                        bail!("Cannot define {identifier} inside another function")
                    }

                    visit_block(body, scope)?;
                }
                scope.pop();
                Ok(())
            }
        }
    }

    fn visit_assignment_lhs(expr: &mut Expression, scope: &mut Scope) -> miette::Result<()> {
        match expr {
            Expression::Var(name) => {
                *name = scope
                    .get(name)
                    .ok_or_else(|| miette!("{name} assigned without being declared"))?
                    .clone();

                Ok(())
            }
            _ => {
                bail!("Cannot assign to non-variable {expr:?}")
            }
        }
    }

    let mut scope = Scope::default();
    scope.push();
    for decl in program.declarations.iter_mut() {
        visit_decl(decl, &mut scope)?
    }
    scope.pop();
    Ok(())
}
