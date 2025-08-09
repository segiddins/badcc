use std::{collections::HashMap, iter::empty};

use crate::tacky;

#[derive(Debug)]
pub struct Program {
    pub definitions: Vec<Function>,
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
    DeallocateStack(u32),
    Push(Operand),
    Call(String),
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
    Register(Reg, Width),
    Psuedo(u32),
    Stack(i32),
}

impl Operand {
    pub const fn width(&self) -> Width {
        match self {
            Operand::Immediate(_) => Width::Four,
            Operand::Register(_, width) => *width,
            Operand::Psuedo(_) | Operand::Stack(_) => Width::Four,
        }
    }
}

#[derive(Debug, Clone, Copy)]
pub enum Reg {
    AX,
    DX,
    CX,
    DI,
    SI,
    R8,
    R9,
    R10,
    R11,
}

impl Reg {
    const fn wide(self) -> Operand {
        Operand::Register(self, Width::Eight)
    }
    const fn quad(self) -> Operand {
        Operand::Register(self, Width::Four)
    }
    const fn word(self) -> Operand {
        Operand::Register(self, Width::One)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Width {
    One,
    Four,
    Eight,
}

impl From<Width> for u32 {
    fn from(value: Width) -> Self {
        match value {
            Width::One => 1,
            Width::Four => 4,
            Width::Eight => 8,
        }
    }
}

impl From<&tacky::Program> for Program {
    fn from(value: &tacky::Program) -> Self {
        let definitions = value.functions.iter().map(|func| func.into()).collect();
        Program { definitions }
    }
}

impl From<&tacky::Function> for Function {
    fn from(value: &tacky::Function) -> Self {
        let instructions = lower_instructions(&value.params, &value.instructions);
        Function {
            name: value.identifier.clone(),
            instructions,
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

impl From<(Reg, Width)> for Operand {
    fn from((reg, width): (Reg, Width)) -> Self {
        Self::Register(reg, width)
    }
}
impl From<(&Reg, Width)> for Operand {
    fn from((reg, width): (&Reg, Width)) -> Self {
        (*reg, width).into()
    }
}

impl From<i32> for Operand {
    fn from(value: i32) -> Self {
        Self::Immediate(value)
    }
}

const REG_ARGS: [Operand; 6] = [
    Reg::DI.quad(),
    Reg::SI.quad(),
    Reg::DX.quad(),
    Reg::CX.quad(),
    Reg::R8.quad(),
    Reg::R9.quad(),
];

impl From<&tacky::Instruction> for Vec<Instruction> {
    fn from(insn: &tacky::Instruction) -> Self {
        match insn {
            tacky::Instruction::Return(val) => {
                vec![Instruction::mov(val, Reg::AX.quad()), Instruction::Ret]
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
                        Instruction::mov(lhs, Reg::AX.quad()),
                        Instruction::Cdq,
                        Instruction::Idiv(rhs.into()),
                        Instruction::mov(Reg::AX.quad(), dst),
                    ]
                }
                tacky::BinaryOperator::Remainder => {
                    vec![
                        Instruction::mov(lhs, Reg::AX.quad()),
                        Instruction::Cdq,
                        Instruction::Idiv(rhs.into()),
                        Instruction::mov(Reg::DX.quad(), dst),
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
            tacky::Instruction::Call(func, args, ret) => {
                let mut instructions = vec![];

                let stack_args = args.iter().skip(REG_ARGS.len()).rev();
                let stack_args_len = stack_args.len() as u32;
                let stack_padding = (stack_args_len * 8) % 16;
                if !stack_padding.is_multiple_of(16) {
                    instructions.push(Instruction::AllocateStack(stack_padding))
                };

                for (param, reg) in args.iter().zip(&REG_ARGS) {
                    instructions.push(Instruction::mov(param, *reg));
                }

                for param in stack_args {
                    let param: Operand = param.into();
                    match param {
                        Operand::Immediate(_) | Operand::Register(_, _) => {
                            instructions.push(Instruction::Push(param))
                        }
                        Operand::Psuedo(_) => {
                            instructions.push(Instruction::mov(param, Reg::AX.quad()));
                            instructions.push(Instruction::Push(Reg::AX.wide()));
                        }
                        Operand::Stack(_) => unreachable!(),
                    }
                }

                instructions.push(Instruction::Call(func.clone()));

                let bytes_to_remove = (8 * stack_args_len) + stack_padding;
                if bytes_to_remove != 0 {
                    instructions.push(Instruction::DeallocateStack(bytes_to_remove));
                }

                instructions.push(Instruction::mov(Reg::AX.quad(), ret));
                instructions
            }
        }
    }
}

/// Returns the size of stack that needs to be allocated
fn replace_pseudo(instructions: &mut [Instruction]) -> u32 {
    let mut max = 8;
    let mut mapping: HashMap<u32, i32> = Default::default();
    let mut m = |op: &mut Operand| {
        match op {
            Operand::Immediate(_) | Operand::Register(_, _) => {}
            Operand::Psuedo(x) => {
                let stack = *mapping.entry(*x).or_insert_with(|| max + 4);
                *op = Operand::Stack(stack);
                max = max.max(stack);
            }
            Operand::Stack(x) => max = max.max(*x),
        };
    };

    for i in instructions {
        match i {
            Instruction::Move {
                source,
                destination,
            } => {
                m(source);
                m(destination);
            }
            Instruction::Unary(_, operand) => m(operand),
            Instruction::Binary(_, operand, operand1) => {
                m(operand);
                m(operand1);
            }
            Instruction::Idiv(operand) => m(operand),
            Instruction::Cmp(operand, operand1) => {
                m(operand);
                m(operand1);
            }
            Instruction::SetCC(_, operand) => m(operand),
            Instruction::Push(operand) => {
                m(operand);
            }
            Instruction::AllocateStack(_)
            | Instruction::Ret
            | Instruction::Cdq
            | Instruction::Jmp(_)
            | Instruction::JmpCC(_, _)
            | Instruction::Label(_)
            | Instruction::DeallocateStack(_)
            | Instruction::Call(_) => {}
        }
    }
    (max as u32).next_multiple_of(16)
}

fn lower_instructions(
    params: &[tacky::Val],
    instructions: &[tacky::Instruction],
) -> Vec<Instruction> {
    let mut v: Vec<Instruction> = empty()
        .chain(
            params
                .iter()
                .zip(REG_ARGS)
                .map(|(var, reg)| Instruction::mov(reg, var)),
        )
        .chain(
            params
                .iter()
                .skip(6)
                .enumerate()
                .map(|(i, param)| Instruction::mov(Operand::Stack(i as i32 * -8 - 16), param)),
        )
        .chain(instructions.iter().flat_map(Into::<Vec<_>>::into))
        .collect();

    let alloc_stack = Instruction::AllocateStack(replace_pseudo(&mut v));
    v.insert(0, alloc_stack);
    v.into_iter()
        .flat_map(|i| match i {
            Instruction::Move {
                source,
                destination,
            } if matches!(source, Operand::Stack(_))
                && matches!(destination, Operand::Stack(_)) =>
            {
                vec![
                    Instruction::mov(source, Reg::R10.quad()),
                    Instruction::mov(Reg::R10.quad(), destination),
                ]
            }
            Instruction::Binary(op, src, dst)
                if matches!(op, BinaryOperator::LeftShift | BinaryOperator::RightShift)
                    && matches!(src, Operand::Stack(_))
                    && matches!(dst, Operand::Stack(_)) =>
            {
                vec![
                    Instruction::mov(dst, Reg::R11.quad()),
                    Instruction::mov(src, Reg::CX.quad()),
                    Instruction::binary(op, Reg::CX.word(), Reg::R11.quad()),
                    Instruction::mov(Reg::R11.quad(), dst),
                ]
            }
            Instruction::Binary(op, src, dst)
                if matches!(
                    op,
                    BinaryOperator::Mult | BinaryOperator::LeftShift | BinaryOperator::RightShift
                ) && matches!(dst, Operand::Stack(_)) =>
            {
                vec![
                    Instruction::mov(dst, Reg::R11.quad()),
                    Instruction::binary(op, src, Reg::R11.quad()),
                    Instruction::mov(Reg::R11.quad(), dst),
                ]
            }
            Instruction::Binary(op, src, dst)
                if matches!(src, Operand::Stack(_)) && matches!(dst, Operand::Stack(_)) =>
            {
                vec![
                    Instruction::mov(src, Reg::R10.quad()),
                    Instruction::binary(op, Reg::R10.quad(), dst),
                ]
            }
            Instruction::Cmp(lhs, rhs)
                if matches!(lhs, Operand::Stack(_)) && matches!(rhs, Operand::Stack(_)) =>
            {
                vec![
                    Instruction::mov(lhs, Reg::R10.quad()),
                    Instruction::Cmp(Reg::R10.quad(), rhs),
                ]
            }
            Instruction::Cmp(lhs, rhs) if matches!(rhs, Operand::Immediate(_)) => {
                vec![
                    Instruction::mov(rhs, Reg::R11.quad()),
                    Instruction::Cmp(lhs, Reg::R11.quad()),
                ]
            }
            Instruction::Idiv(Operand::Immediate(val)) => {
                vec![
                    Instruction::mov(Operand::Immediate(val), Reg::R10.quad()),
                    Instruction::Idiv(Reg::R10.quad()),
                ]
            }

            _ => vec![i],
        })
        .collect()
}

pub fn generate_assembly(program: &tacky::Program) -> Program {
    program.into()
}
