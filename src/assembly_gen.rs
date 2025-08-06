use crate::tacky::{self};

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
pub enum CondCode {
    E,
    NE,
    G,
    GE,
    L,
    LE,
}

#[derive(Debug)]
pub enum Instruction {
    Move {
        source: Operand,
        destination: Operand,
    },
    Unary(UnaryOperator, Operand),
    Binary(BinaryOperator, Operand, Operand),
    Cmp(Operand, Operand),
    Idiv(Operand),
    Cdq,
    Jmp(String),
    JmpCC(CondCode, String),
    SetCC(CondCode, Operand),
    Label(String),
    AllocateStack(u32),
    Ret,
}

impl Instruction {
    fn mov(src: impl Into<Operand>, dst: impl Into<Operand>) -> Self {
        Self::Move {
            source: src.into(),
            destination: dst.into(),
        }
    }

    fn unary(op: impl Into<UnaryOperator>, dst: impl Into<Operand>) -> Self {
        Self::Unary(op.into(), dst.into())
    }

    fn binary(
        op: impl Into<BinaryOperator>,
        lhs: impl Into<Operand>,
        rhs: impl Into<Operand>,
    ) -> Self {
        Self::Binary(op.into(), lhs.into(), rhs.into())
    }
}

#[derive(Debug)]
pub enum UnaryOperator {
    Neg,
    Not,
}
#[derive(Debug)]
pub enum BinaryOperator {
    Add,
    Sub,
    Mult,
    And,
    Or,
    Xor,
    LeftShift,
    RightShift,
    Equals,
    NotEquals,
    LessThan,
    LessThanOrEqual,
    GreaterThan,
    GreaterThanOrEqual,
}

#[derive(Debug, Clone, Copy)]
pub enum Operand {
    Immediate(i32),
    Register(Reg),
    Psuedo(u32),
}

#[derive(Debug, Clone, Copy)]
pub enum Reg {
    AX,
    DX,
    R10,
    R11,
    CL,
}

impl AsRef<str> for Reg {
    fn as_ref(&self) -> &'static str {
        match self {
            Reg::AX => "eax",
            Reg::DX => "edx",
            Reg::R10 => "r10d",
            Reg::R11 => "r11d",
            Reg::CL => "ecx",
        }
    }
}

impl From<&tacky::Program> for Program {
    fn from(value: &tacky::Program) -> Self {
        Program {
            function_definition: (&value.function_definition).into(),
        }
    }
}

impl From<&tacky::Function> for Function {
    fn from(value: &tacky::Function) -> Self {
        Function {
            name: value.identifier.clone(),
            instructions: lower_instructions(&value.instructions),
        }
    }
}

impl From<&tacky::UnaryOperator> for UnaryOperator {
    fn from(value: &tacky::UnaryOperator) -> Self {
        match value {
            tacky::UnaryOperator::Complement => UnaryOperator::Not,
            tacky::UnaryOperator::Negate => UnaryOperator::Neg,
            tacky::UnaryOperator::Not => UnaryOperator::Not,
        }
    }
}
impl From<&tacky::BinaryOperator> for BinaryOperator {
    fn from(value: &tacky::BinaryOperator) -> Self {
        match value {
            tacky::BinaryOperator::Add => BinaryOperator::Add,
            tacky::BinaryOperator::Subtract => BinaryOperator::Sub,
            tacky::BinaryOperator::Multiply => BinaryOperator::Mult,
            tacky::BinaryOperator::Divide => unreachable!(),
            tacky::BinaryOperator::Remainder => unreachable!(),
            tacky::BinaryOperator::LeftShift => BinaryOperator::LeftShift,
            tacky::BinaryOperator::RightShift => BinaryOperator::RightShift,
            tacky::BinaryOperator::BitwiseOr => BinaryOperator::Or,
            tacky::BinaryOperator::BitwiseAnd => BinaryOperator::And,
            tacky::BinaryOperator::Xor => BinaryOperator::Xor,
            tacky::BinaryOperator::Equals => BinaryOperator::Equals,
            tacky::BinaryOperator::LessThan => BinaryOperator::LessThan,
            tacky::BinaryOperator::LessThanOrEqual => Self::LessThanOrEqual,
            tacky::BinaryOperator::GreaterThan => Self::GreaterThan,
            tacky::BinaryOperator::GreaterThanOrEqual => Self::GreaterThanOrEqual,
            tacky::BinaryOperator::NotEqual => Self::NotEquals,
            tacky::BinaryOperator::And => Self::And,
            tacky::BinaryOperator::Or => Self::Or,
        }
    }
}

impl From<&tacky::BinaryOperator> for CondCode {
    fn from(value: &tacky::BinaryOperator) -> Self {
        use CondCode::*;
        use tacky::BinaryOperator::*;
        match value {
            Equals => E,
            NotEqual => NE,
            LessThan => L,
            LessThanOrEqual => LE,
            GreaterThan => G,
            GreaterThanOrEqual => GE,
            Or => NE,
            And => NE,
            value => unreachable!("{value:?} is not a valid CondCode"),
        }
    }
}

impl From<&tacky::Val> for Operand {
    fn from(value: &tacky::Val) -> Self {
        match value {
            tacky::Val::Constant(c) => Self::Immediate(*c),
            tacky::Val::Var(id) => Self::Psuedo(*id),
        }
    }
}

impl From<Reg> for Operand {
    fn from(value: Reg) -> Self {
        Self::Register(value)
    }
}

impl From<i32> for Operand {
    fn from(value: i32) -> Self {
        Self::Immediate(value)
    }
}

impl From<&tacky::Instruction> for Vec<Instruction> {
    fn from(insn: &tacky::Instruction) -> Self {
        match insn {
            tacky::Instruction::Return(val) => {
                vec![Instruction::mov(val, Reg::AX), Instruction::Ret]
            }
            tacky::Instruction::Unary { op, src, dst } => match op {
                tacky::UnaryOperator::Not => {
                    vec![
                        Instruction::Cmp(Operand::Immediate(0), src.into()),
                        Instruction::mov(Operand::Immediate(0), dst),
                        Instruction::SetCC(CondCode::E, dst.into()),
                    ]
                }
                op => vec![Instruction::mov(src, dst), Instruction::unary(op, dst)],
            },
            tacky::Instruction::Binary { op, lhs, rhs, dst } => match op {
                tacky::BinaryOperator::Divide => {
                    vec![
                        Instruction::mov(lhs, Reg::AX),
                        Instruction::Cdq,
                        Instruction::Idiv(rhs.into()),
                        Instruction::mov(Reg::AX, dst),
                    ]
                }
                tacky::BinaryOperator::Remainder => {
                    vec![
                        Instruction::mov(lhs, Reg::AX),
                        Instruction::Cdq,
                        Instruction::Idiv(rhs.into()),
                        Instruction::mov(Reg::DX, dst),
                    ]
                }
                tacky::BinaryOperator::And
                | tacky::BinaryOperator::Or
                | tacky::BinaryOperator::Equals
                | tacky::BinaryOperator::NotEqual
                | tacky::BinaryOperator::GreaterThan
                | tacky::BinaryOperator::GreaterThanOrEqual
                | tacky::BinaryOperator::LessThan
                | tacky::BinaryOperator::LessThanOrEqual => {
                    vec![
                        Instruction::Cmp(rhs.into(), lhs.into()),
                        Instruction::mov(0, dst),
                        Instruction::SetCC(op.into(), dst.into()),
                    ]
                }
                op => {
                    vec![
                        Instruction::mov(lhs, dst),
                        Instruction::binary(op, rhs, dst),
                    ]
                }
            },
            tacky::Instruction::Copy { src, dst } => vec![Instruction::mov(src, dst)],
            tacky::Instruction::Jump(dst) => vec![Instruction::Jmp(dst.clone())],
            tacky::Instruction::JumpIfZero(val, target) => vec![
                Instruction::Cmp(Operand::Immediate(0), val.into()),
                Instruction::JmpCC(CondCode::E, target.into()),
            ],
            tacky::Instruction::JumpIfNotZero(val, target) => vec![
                Instruction::Cmp(Operand::Immediate(0), val.into()),
                Instruction::JmpCC(CondCode::NE, target.into()),
            ],
            tacky::Instruction::Label(label) => vec![Instruction::Label(label.clone())],
        }
    }
}

fn replace_pseudo(instructions: impl Iterator<Item = Vec<Instruction>>) -> u32 {
    fn m(op: &Operand) -> u32 {
        match op {
            Operand::Immediate(_) => 0,
            Operand::Register(_) => 0,
            Operand::Psuedo(x) => *x,
        }
    }
    instructions
        .flatten()
        .map(|i| match i {
            Instruction::Move {
                source,
                destination,
            } => m(&source).max(m(&destination)),
            Instruction::Unary(_, operand) => m(&operand),
            Instruction::AllocateStack(_) => unreachable!(),
            Instruction::Ret => 0,
            Instruction::Binary(_, operand, operand1) => m(&operand).max(m(&operand1)),
            Instruction::Idiv(operand) => m(&operand),
            Instruction::Cdq => 0,
            Instruction::Cmp(operand, operand1) => m(&operand).max(m(&operand1)),
            Instruction::Jmp(_) => 0,
            Instruction::JmpCC(_, _) => 0,
            Instruction::SetCC(_, operand) => m(&operand),
            Instruction::Label(_) => 0,
        })
        .max()
        .unwrap_or_default()
}

fn lower_instructions(instructions: &[tacky::Instruction]) -> Vec<Instruction> {
    let mut v: Vec<_> = instructions.iter().flat_map(Into::<Vec<_>>::into).collect();
    v.insert(
        0,
        Instruction::AllocateStack(replace_pseudo(instructions.iter().map(|i| i.into())) * 4 + 4),
    );
    v.into_iter()
        .flat_map(|i| match i {
            Instruction::Move {
                source,
                destination,
            } if matches!(source, Operand::Psuedo(_))
                && matches!(destination, Operand::Psuedo(_)) =>
            {
                vec![
                    Instruction::mov(source, Reg::R10),
                    Instruction::mov(Reg::R10, destination),
                ]
            }
            Instruction::Binary(op, src, dst)
                if matches!(op, BinaryOperator::LeftShift | BinaryOperator::RightShift)
                    && matches!(src, Operand::Psuedo(_))
                    && matches!(dst, Operand::Psuedo(_)) =>
            {
                vec![
                    Instruction::mov(dst, Reg::R11),
                    Instruction::mov(src, Reg::CL),
                    Instruction::binary(op, Reg::CL, Reg::R11),
                    Instruction::mov(Reg::R11, dst),
                ]
            }
            Instruction::Binary(op, src, dst)
                if matches!(
                    op,
                    BinaryOperator::Mult | BinaryOperator::LeftShift | BinaryOperator::RightShift
                ) && matches!(dst, Operand::Psuedo(_)) =>
            {
                vec![
                    Instruction::mov(dst, Reg::R11),
                    Instruction::binary(op, src, Reg::R11),
                    Instruction::mov(Reg::R11, dst),
                ]
            }
            Instruction::Binary(op, src, dst)
                if matches!(src, Operand::Psuedo(_)) && matches!(dst, Operand::Psuedo(_)) =>
            {
                vec![
                    Instruction::mov(src, Reg::R10),
                    Instruction::binary(op, Reg::R10, dst),
                ]
            }
            Instruction::Cmp(lhs, rhs)
                if matches!(lhs, Operand::Psuedo(_)) && matches!(rhs, Operand::Psuedo(_)) =>
            {
                vec![
                    Instruction::mov(lhs, Reg::R10),
                    Instruction::Cmp(Reg::R10.into(), rhs),
                ]
            }
            Instruction::Cmp(lhs, rhs) if matches!(rhs, Operand::Immediate(_)) => {
                vec![
                    Instruction::mov(rhs, Reg::R11),
                    Instruction::Cmp(lhs, Reg::R11.into()),
                ]
            }
            Instruction::Idiv(Operand::Immediate(val)) => {
                vec![
                    Instruction::mov(Operand::Immediate(val), Reg::R10),
                    Instruction::Idiv(Reg::R10.into()),
                ]
            }

            _ => vec![i],
        })
        .collect()
}

pub fn generate_assembly(program: &tacky::Program) -> Program {
    program.into()
}
