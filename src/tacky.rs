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
}

pub fn lower(program: &parser::Program) -> Program {
    Program {
        function_definition: lower_function(&program.function),
    }
}

pub fn lower_function(function: &parser::Function) -> Function {
    let mut temps = 0u32;
    let mut instructions: Vec<Instruction> = vec![];

    fn var(temps: &mut u32) -> Val {
        let v = Val::Var(*temps);
        *temps += 1;
        v
    }

    fn walk(expr: &Expression, instructions: &mut Vec<Instruction>, temps: &mut u32) -> Val {
        match expr {
            Expression::Constant(val) => Val::Constant(*val),
            Expression::UnaryOperation(unary_operator, expression) => match unary_operator {
                parser::UnaryOperator::Minus => {
                    let src = walk(expression, instructions, temps);
                    let dst = var(temps);
                    instructions.push(Instruction::Unary {
                        op: UnaryOperator::Negate,
                        src,
                        dst,
                    });
                    dst
                }
                parser::UnaryOperator::Complement => {
                    let src = walk(expression, instructions, temps);
                    let dst = var(temps);
                    instructions.push(Instruction::Unary {
                        op: UnaryOperator::Complement,
                        src,
                        dst,
                    });
                    dst
                }
            },
        }
    }

    match &function.statement {
        Statement::Return(expression) => {
            let ret = walk(expression, &mut instructions, &mut temps);
            instructions.push(Instruction::Return(ret));
        }
    }

    Function {
        identifier: function.identifier.clone(),
        instructions,
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
