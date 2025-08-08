use std::collections::HashMap;

pub use crate::parser::BinaryOperator;
use crate::parser::{self, Block, BlockItem, Expression, Statement, VariableDeclaration};

#[derive(Debug)]
pub struct Program {
    pub function_definition: Function,
}

#[derive(Debug)]
pub struct Function {
    pub identifier: String,
    pub instructions: Vec<Instruction>,
}

#[derive(Debug)]
pub enum Instruction {
    Return(Val),
    Unary {
        op: UnaryOperator,
        src: Val,
        dst: Val,
    },
    Binary {
        op: BinaryOperator,
        lhs: Val,
        rhs: Val,
        dst: Val,
    },
    Copy {
        src: Val,
        dst: Val,
    },
    Jump(String),
    JumpIfZero(Val, String),
    JumpIfNotZero(Val, String),
    Label(String),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Val {
    Constant(i32),
    Var(u32),
}

#[derive(Debug)]
pub enum UnaryOperator {
    Complement,
    Negate,
    Not,
}

pub fn lower(program: &parser::Program) -> Program {
    Program {
        function_definition: lower_function(&program.function),
    }
}

pub fn lower_function(function: &parser::Function) -> Function {
    struct State<'i> {
        temps: u32,
        instructions: Vec<Instruction>,
        phis: u32,
        name: &'i str,
        variables: HashMap<String, Val>,
    }
    impl State<'_> {
        fn var(&mut self) -> Val {
            let v = Val::Var(self.temps);
            self.temps += 1;
            v
        }

        fn push(&mut self, instruction: Instruction) {
            self.instructions.push(instruction);
        }
    }

    fn walk<'i>(expr: &Expression, state: &mut State<'i>) -> Val {
        match expr {
            Expression::Constant(val) => Val::Constant(*val),
            Expression::Unary(unary_operator, expression) => {
                let src = walk(expression, state);
                match unary_operator {
                    parser::UnaryOperator::Minus => {
                        let dst = state.var();
                        state.push(Instruction::Unary {
                            op: UnaryOperator::Negate,
                            src,
                            dst,
                        });
                        dst
                    }
                    parser::UnaryOperator::Complement => {
                        let dst = state.var();
                        state.push(Instruction::Unary {
                            op: UnaryOperator::Complement,
                            src,
                            dst,
                        });
                        dst
                    }
                    parser::UnaryOperator::Not => {
                        let dst = state.var();
                        state.push(Instruction::Unary {
                            op: UnaryOperator::Not,
                            src,
                            dst,
                        });
                        dst
                    }
                    parser::UnaryOperator::PrefixIncrement => {
                        state.push(Instruction::Binary {
                            op: BinaryOperator::Add,
                            lhs: src,
                            rhs: Val::Constant(1),
                            dst: src,
                        });
                        src
                    }
                    parser::UnaryOperator::PrefixDecrement => {
                        state.push(Instruction::Binary {
                            op: BinaryOperator::Add,
                            lhs: src,
                            rhs: Val::Constant(-1),
                            dst: src,
                        });
                        src
                    }
                    parser::UnaryOperator::PostfixIncrement => {
                        let dst = state.var();
                        state.push(Instruction::Copy { src, dst });
                        state.push(Instruction::Binary {
                            op: BinaryOperator::Add,
                            lhs: src,
                            rhs: Val::Constant(1),
                            dst: src,
                        });
                        dst
                    }
                    parser::UnaryOperator::PostfixDecrement => {
                        let dst = state.var();
                        state.push(Instruction::Copy { src, dst });
                        state.push(Instruction::Binary {
                            op: BinaryOperator::Add,
                            lhs: src,
                            rhs: Val::Constant(-1),
                            dst: src,
                        });
                        dst
                    }
                }
            }
            Expression::Binary(BinaryOperator::And, lhs, rhs) => {
                let phi = state.var();
                let lhs = walk(lhs, state);
                let false_label = format!("{}.{}.false", state.name, state.phis);
                let end_label = format!("{}.{}.end", state.name, state.phis);
                state.phis += 1;
                state.push(Instruction::JumpIfZero(lhs, false_label.clone()));
                let rhs = walk(rhs, state);
                state.push(Instruction::JumpIfZero(rhs, false_label.clone()));
                state.push(Instruction::Copy {
                    src: Val::Constant(1),
                    dst: phi,
                });
                state.push(Instruction::Jump(end_label.clone()));
                state.push(Instruction::Label(false_label));
                state.push(Instruction::Copy {
                    src: Val::Constant(0),
                    dst: phi,
                });
                state.push(Instruction::Label(end_label));

                phi
            }
            Expression::Binary(BinaryOperator::Or, lhs, rhs) => {
                let phi = state.var();
                let lhs = walk(lhs, state);
                let true_label = format!("{}.{}.true", state.name, state.phis);
                let end_label = format!("{}.{}.end", state.name, state.phis);
                state.phis += 1;
                state.push(Instruction::JumpIfNotZero(lhs, true_label.clone()));
                let rhs = walk(rhs, state);
                state.push(Instruction::JumpIfNotZero(rhs, true_label.clone()));
                state.push(Instruction::Copy {
                    src: Val::Constant(0),
                    dst: phi,
                });
                state.push(Instruction::Jump(end_label.clone()));
                state.push(Instruction::Label(true_label));
                state.push(Instruction::Copy {
                    src: Val::Constant(1),
                    dst: phi,
                });
                state.push(Instruction::Label(end_label));

                phi
            }
            Expression::Binary(op, lhs, rhs) => {
                let lhs = walk(lhs, state);
                let rhs = walk(rhs, state);
                let dst = state.var();
                state.push(Instruction::Binary {
                    op: *op,
                    lhs,
                    rhs,
                    dst,
                });
                dst
            }
            Expression::Var(name) => *state.variables.get(name).unwrap(),
            Expression::Assignment(lhs, rhs) => {
                let rhs = walk(rhs, state);
                let lhs = walk(lhs, state);
                state.push(Instruction::Copy { src: rhs, dst: lhs });
                lhs
            }
            Expression::CompoundAssignment(lhs, op, rhs) => {
                let rhs = walk(rhs, state);
                let lhs = walk(lhs, state);
                state.push(Instruction::Binary {
                    op: *op,
                    lhs,
                    rhs,
                    dst: lhs,
                });
                lhs
            }
            Expression::Ternary(cond, then, r#else) => {
                let phi = state.var();
                let else_label = format!("{}.{}.true", state.name, state.phis);
                let end_label = format!("{}.{}.end", state.name, state.phis);
                state.phis += 1;

                let cond = walk(cond, state);
                state.push(Instruction::JumpIfZero(cond, else_label.clone()));
                let src = walk(then, state);
                state.push(Instruction::Copy { src, dst: phi });
                state.push(Instruction::Jump(end_label.clone()));
                state.push(Instruction::Label(else_label));
                let src = walk(r#else, state);
                state.push(Instruction::Copy { src, dst: phi });
                state.push(Instruction::Label(end_label));
                phi
            }
        }
    }

    fn walk_optional<'i>(expr: &Option<Expression>, state: &mut State<'i>) -> Option<Val> {
        expr.as_ref().map(|e| walk(e, state))
    }

    fn walk_statement<'i>(statement: &Statement, state: &mut State<'i>) {
        match statement {
            Statement::Return(expression) => {
                let ret = walk(expression, state);
                state.push(Instruction::Return(ret));
            }
            Statement::Expression(expression) => {
                walk(expression, state);
            }
            Statement::If(cond, then, r#else) => {
                let else_label = format!("{}.{}.true", state.name, state.phis);
                let end_label = format!("{}.{}.end", state.name, state.phis);
                state.phis += 1;

                let cond = walk(cond, state);
                state.push(Instruction::JumpIfZero(cond, else_label.clone()));
                walk_statement(then, state);
                state.push(Instruction::Jump(end_label.clone()));
                state.push(Instruction::Label(else_label));
                if let Some(r#else) = r#else {
                    walk_statement(r#else, state);
                }
                state.push(Instruction::Label(end_label));
            }
            Statement::Goto(label) => {
                state.push(Instruction::Jump(label.clone()));
            }
            Statement::Labeled(label, statement) => {
                state.push(Instruction::Label(label.clone()));
                walk_statement(statement, state);
            }
            Statement::Compound(block) => {
                walk_block(block, state);
            }
            Statement::Null => {}
            Statement::Break(label) => {
                state.push(Instruction::Jump(label.as_ref().unwrap().clone()));
            }
            Statement::Continue(label) => {
                let label = label.as_ref().unwrap();
                state.push(Instruction::Jump(format!("{label}.start")));
            }
            Statement::While(expression, statement, label) => {
                let label = label.as_ref().unwrap();
                let start_label = format!("{label}.start");

                state.push(Instruction::Label(start_label.clone()));
                let cond = walk(expression, state);
                state.push(Instruction::JumpIfZero(cond, label.clone()));

                walk_statement(statement, state);
                state.push(Instruction::Jump(start_label));

                state.push(Instruction::Label(label.clone()));
            }
            Statement::DoWhile(statement, expression, label) => {
                let label = label.as_ref().unwrap();
                let head_label = format!("{label}.head");
                let start_label = format!("{label}.start");

                state.push(Instruction::Label(head_label.clone()));
                walk_statement(statement, state);
                state.push(Instruction::Label(start_label));

                let cond = walk(expression, state);
                state.push(Instruction::JumpIfNotZero(cond, head_label));

                state.push(Instruction::Label(label.clone()));
            }
            Statement::For {
                init,
                condition,
                post,
                body,
                label,
            } => {
                let end_label = label.as_ref().unwrap().clone();
                let cond_label = format!("{end_label}.cond");
                let start_label = format!("{end_label}.start");

                match init {
                    parser::ForInit::Decl(variable_declaration) => {
                        walk_declaration(variable_declaration, state)
                    }
                    parser::ForInit::Expr(expression) => {
                        walk_optional(expression, state);
                    }
                };
                state.push(Instruction::Label(cond_label.clone()));

                if let Some(cond) = walk_optional(condition, state) {
                    state.push(Instruction::JumpIfZero(cond, end_label.clone()))
                }

                walk_statement(body, state);

                state.push(Instruction::Label(start_label));

                walk_optional(post, state);

                state.push(Instruction::Jump(cond_label));
                state.push(Instruction::Label(end_label));
            }
        }
    }

    fn walk_declaration<'i>(decl: &VariableDeclaration, state: &mut State<'i>) {
        let var = state.var();
        state.variables.insert(decl.name.clone(), var);
        if let Some(rhs) = walk_optional(&decl.init, state) {
            state.push(Instruction::Copy { src: rhs, dst: var })
        }
    }

    fn walk_block<'i>(block: &Block, state: &mut State<'i>) {
        for item in block.items.iter() {
            match &item {
                BlockItem::Statement(statement) => walk_statement(statement, state),
                BlockItem::Declaration(decl) => walk_declaration(decl, state),
            }
        }
    }

    let mut state = State {
        temps: 0,
        instructions: vec![],
        phis: 0,
        name: &function.name,
        variables: Default::default(),
    };

    walk_block(&function.body, &mut state);

    state.push(Instruction::Return(Val::Constant(0)));

    Function {
        identifier: function.name.clone(),
        instructions: state.instructions,
    }
}

#[cfg(test)]
mod tests {
    use insta::assert_debug_snapshot;

    use crate::{
        parser::{Block, BlockItem, Function, Program, Statement},
        tacky::lower,
    };

    #[test]
    fn test_basic() {
        let program = Program {
            function: Function {
                name: "main".into(),
                body: Block {
                    items: vec![BlockItem::Statement(Statement::Return(
                        crate::parser::Expression::Constant(2),
                    ))],
                },
            },
        };

        assert_debug_snapshot!(lower(&program), @r#"
        Program {
            function_definition: Function {
                identifier: "main",
                instructions: [
                    Return(
                        Constant(
                            2,
                        ),
                    ),
                    Return(
                        Constant(
                            0,
                        ),
                    ),
                ],
            },
        }
        "#);
    }
}
