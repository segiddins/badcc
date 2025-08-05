use crate::parser::{self, Expression, Statement};

#[derive(Debug)]
pub struct Program {
    pub function_definition: Function,
}

#[derive(Debug)]
pub struct Function {
    pub name: String,
    pub instructions: Vec<Instruction>,
}

#[derive(Debug)]
pub enum Instruction {
    Move {
        source: Operand,
        destination: Operand,
    },
    Ret,
}

#[derive(Debug)]
pub enum Operand {
    Immediate(i32),
    Register,
}

impl From<&parser::Program> for Program {
    fn from(value: &parser::Program) -> Self {
        Program {
            function_definition: (&value.function).into(),
        }
    }
}

impl From<&parser::Function> for Function {
    fn from(value: &parser::Function) -> Self {
        Function {
            name: value.identifier.clone(),
            instructions: (&value.statement).into(),
        }
    }
}

impl From<&Statement> for Vec<Instruction> {
    fn from(value: &Statement) -> Self {
        match value {
            Statement::Return(expression) => match expression {
                Expression::Constant(value) => vec![
                    Instruction::Move {
                        source: Operand::Immediate(*value),
                        destination: Operand::Register,
                    },
                    Instruction::Ret,
                ],
            },
        }
    }
}

pub fn generate_assembly(program: &parser::Program) -> Program {
    program.into()
}
