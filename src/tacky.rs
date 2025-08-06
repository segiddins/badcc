
pub use crate::parser::BinaryOperator;
use crate::parser::{self, Expression, Statement};

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
            Expression::Unary(unary_operator, expression) => match unary_operator {
                parser::UnaryOperator::Minus => {
                    let src = walk(expression, state);
                    let dst = state.var();
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Negate,
                        src,
                        dst,
                    });
                    dst
                }
                parser::UnaryOperator::Complement => {
                    let src = walk(expression, state);
                    let dst = state.var();
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Complement,
                        src,
                        dst,
                    });
                    dst
                }
                parser::UnaryOperator::Not => {
                    let src = walk(expression, state);
                    let dst = state.var();
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Not,
                        src,
                        dst,
                    });
                    dst
                }
            },
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
        }
    }

    let mut state = State {
        temps: 0,
        instructions: vec![],
        phis: 0,
        name: &function.identifier,
    };

    match &function.statement {
        Statement::Return(expression) => {
            let ret = walk(expression, &mut state);
            state.push(Instruction::Return(ret));
        }
    }

    Function {
        identifier: function.identifier.clone(),
        instructions: state.instructions,
    }
}

#[cfg(test)]
mod tests {
    use insta::assert_debug_snapshot;

    use crate::{
        parser::{Function, Program, Statement},
        tacky::lower,
    };

    #[test]
    fn test_basic() {
        let program = Program {
            function: Function {
                identifier: "main".into(),
                statement: Statement::Return(crate::parser::Expression::Constant(2)),
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
                ],
            },
        }
        "#);
    }
}
