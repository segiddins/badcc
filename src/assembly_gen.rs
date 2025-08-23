use std::{collections::HashMap, iter::empty};

use crate::{
    sema::{Symbol, SymbolAttributes, SymbolTable},
    tacky,
};

#[derive(Debug)]
pub struct Program {
    pub definitions: Vec<Function>,
    pub static_variables: Vec<StaticVariable>,
}

#[derive(Debug)]
pub struct Function {
    pub name: String,
    pub global: bool,
    pub instructions: Vec<Instruction>,
}

#[derive(Debug, PartialEq, Eq, Clone)]
pub enum CondCode {
    E,
    NE,
    G,
    GE,
    L,
    LE,
}

#[derive(Debug, PartialEq, Eq, Clone)]
pub enum Instruction {
    Move {
        source: Operand,
        destination: Operand,
    },
    Movesx {
        source: Operand,
        destination: Operand,
    },
    Unary(UnaryOperator, Operand),
    Binary(BinaryOperator, Operand, Operand),
    Cmp(Operand, Operand),
    Idiv(Operand),
    Cdq(Width),
    Jmp(String),
    JmpCC(CondCode, String),
    SetCC(CondCode, Operand),
    Label(String),
    AllocateStack(u32),
    DeallocateStack(u32),
    Push(Operand),
    Call(String),
    Comment(String),
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

#[derive(Debug, PartialEq, Eq, Clone)]
pub enum UnaryOperator {
    Neg,
    Not,
}
#[derive(Debug, PartialEq, Eq, Clone)]
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

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Operand {
    Immediate(i64, Width),
    Register(Reg, Width),
    Psuedo(String, Width),
    Stack(i32, Width),
    Data(String, Width),
}

impl Operand {
    pub const fn width(&self) -> Width {
        match self {
            Operand::Immediate(_, width)
            | Operand::Register(_, width)
            | Operand::Psuedo(_, width)
            | Operand::Stack(_, width)
            | Operand::Data(_, width) => *width,
        }
    }

    pub const fn outside_int_range(&self) -> bool {
        match self {
            Operand::Immediate(v, _) => *v > i32::MAX as i64 || *v < i32::MIN as i64,
            _ => false,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
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
    const fn word(self) -> Operand {
        Operand::Register(self, Width::One)
    }

    const fn width(self, width: Width) -> Operand {
        Operand::Register(self, width)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum Width {
    One,
    Four,
    Eight,
}

impl Width {
    pub const fn bytes(&self) -> i32 {
        match self {
            Width::One => 1,
            Width::Four => 4,
            Width::Eight => 8,
        }
    }
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

#[derive(Debug)]
pub struct StaticVariable {
    pub global: bool,
    pub name: String,
    pub value: i64,
    pub alignment: i32,
}

impl From<&tacky::StaticVariable> for StaticVariable {
    fn from(value: &tacky::StaticVariable) -> Self {
        StaticVariable {
            global: value.global,
            name: value.identifier.clone(),
            value: value.init,
            alignment: value.width.bytes(),
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
            tacky::BinaryOperator::Add => Self::Add,
            tacky::BinaryOperator::Subtract => Self::Sub,
            tacky::BinaryOperator::Multiply => Self::Mult,
            tacky::BinaryOperator::Divide => unreachable!(),
            tacky::BinaryOperator::Remainder => unreachable!(),
            tacky::BinaryOperator::LeftShift => Self::LeftShift,
            tacky::BinaryOperator::RightShift => Self::RightShift,
            tacky::BinaryOperator::BitwiseOr => Self::Or,
            tacky::BinaryOperator::BitwiseAnd => Self::And,
            tacky::BinaryOperator::Xor => Self::Xor,
            tacky::BinaryOperator::Equals => Self::Equals,
            tacky::BinaryOperator::LessThan => Self::LessThan,
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
            tacky::Val::Constant(c) => match c {
                crate::parser::Constant::Int(_) => Self::Immediate(c.into_long(), Width::Four),
                crate::parser::Constant::Long(_) => Self::Immediate(c.into_long(), Width::Eight),
            },
            tacky::Val::Var(id, ty) => Self::Psuedo(id.clone(), ty.width()),
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
        Self::Immediate(value as i64, Width::Four)
    }
}

impl From<i64> for Operand {
    fn from(value: i64) -> Self {
        Self::Immediate(value, Width::Eight)
    }
}

const REG_ARGS: [Reg; 6] = [Reg::DI, Reg::SI, Reg::DX, Reg::CX, Reg::R8, Reg::R9];

impl From<&tacky::Instruction> for Vec<Instruction> {
    fn from(insn: &tacky::Instruction) -> Self {
        match insn {
            tacky::Instruction::Return(val) => {
                vec![
                    Instruction::mov(val, Reg::AX.width(val.ty().width())),
                    Instruction::Ret,
                ]
            }
            tacky::Instruction::Unary { op, src, dst } => match op {
                tacky::UnaryOperator::Not => {
                    vec![
                        Instruction::Cmp(Operand::Immediate(0, Width::Four), src.into()),
                        Instruction::mov(Operand::Immediate(0, Width::Four), dst),
                        Instruction::SetCC(CondCode::E, dst.into()),
                    ]
                }
                op => vec![Instruction::mov(src, dst), Instruction::unary(op, dst)],
            },
            tacky::Instruction::Binary { op, lhs, rhs, dst } => match op {
                tacky::BinaryOperator::Divide => {
                    vec![
                        Instruction::mov(lhs, Reg::AX.width(lhs.ty().width())),
                        Instruction::Cdq(lhs.ty().width()),
                        Instruction::Idiv(rhs.into()),
                        Instruction::mov(Reg::AX.width(dst.ty().width()), dst),
                    ]
                }
                tacky::BinaryOperator::Remainder => {
                    vec![
                        Instruction::mov(lhs, Reg::AX.width(lhs.ty().width())),
                        Instruction::Cdq(lhs.ty().width()),
                        Instruction::Idiv(rhs.into()),
                        Instruction::mov(Reg::DX.width(dst.ty().width()), dst),
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
                Instruction::Cmp(Operand::Immediate(0, Width::Four), val.into()),
                Instruction::JmpCC(CondCode::E, target.into()),
            ],
            tacky::Instruction::JumpIfNotZero(val, target) => vec![
                Instruction::Cmp(Operand::Immediate(0, Width::Four), val.into()),
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
                    instructions.push(Instruction::mov(param, reg.width(param.ty().width())));
                }

                for param in stack_args {
                    let param: Operand = param.into();
                    match param {
                        Operand::Immediate(_, _) | Operand::Register(_, _) => {
                            instructions.push(Instruction::Push(param))
                        }
                        Operand::Psuedo(_, width) | Operand::Data(_, width) => {
                            instructions.push(Instruction::mov(param, Reg::AX.width(width)));
                            instructions.push(Instruction::Push(Reg::AX.width(Width::Eight)));
                        }
                        Operand::Stack(_, _) => unreachable!(),
                    }
                }

                instructions.push(Instruction::Call(func.clone()));

                let bytes_to_remove = (8 * stack_args_len) + stack_padding;
                if bytes_to_remove != 0 {
                    instructions.push(Instruction::DeallocateStack(bytes_to_remove));
                }

                instructions.push(Instruction::mov(Reg::AX.width(ret.ty().width()), ret));
                instructions
            }
            tacky::Instruction::SignExtend { src, dst } => vec![Instruction::Movesx {
                source: src.into(),
                destination: dst.into(),
            }],
            tacky::Instruction::Truncate { src, dst } => vec![Instruction::mov(
                match src {
                    tacky::Val::Constant(constant) => {
                        Operand::Immediate(constant.into_long() as i32 as i64, dst.ty().width())
                    }
                    tacky::Val::Var(name, _) => Operand::Psuedo(name.clone(), dst.ty().width()),
                },
                dst,
            )],
        }
    }
}

/// Returns the size of stack that needs to be allocated
fn replace_pseudo(instructions: &mut [Instruction], symbols: &SymbolTable) -> u32 {
    let mut max = 8;
    let mut mapping: HashMap<String, i32> = Default::default();
    let mut m = |op: &mut Operand| {
        match op {
            Operand::Immediate(_, _) | Operand::Register(_, _) | Operand::Data(_, _) => {}
            Operand::Psuedo(x, width) => match symbols.get(x) {
                None
                | Some(Symbol {
                    attributes: SymbolAttributes::Local,
                    ..
                }) => {
                    let stack = *mapping
                        .entry(x.clone())
                        .or_insert_with(|| max + width.bytes());
                    *op = Operand::Stack(stack, *width);
                    max = max.max(stack);
                }
                _ => *op = Operand::Data(x.clone(), *width),
            },
            Operand::Stack(x, _) => max = max.max(*x),
        };
    };

    for i in instructions {
        match i {
            Instruction::Move {
                source,
                destination,
            }
            | Instruction::Movesx {
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
            | Instruction::Cdq(_)
            | Instruction::Jmp(_)
            | Instruction::JmpCC(_, _)
            | Instruction::Label(_)
            | Instruction::DeallocateStack(_)
            | Instruction::Call(_)
            | Instruction::Comment(_) => {}
        }
    }
    (max as u32).next_multiple_of(16)
}

fn lower_instructions(
    params: &[tacky::Val],
    instructions: &[tacky::Instruction],
    symbols: &SymbolTable,
) -> Vec<Instruction> {
    let mut v: Vec<Instruction> = empty()
        .chain(
            params
                .iter()
                .zip(REG_ARGS)
                .map(|(var, reg)| Instruction::mov(reg.width(var.ty().width()), var)),
        )
        .chain(
            params
                .iter()
                .skip(REG_ARGS.len())
                .enumerate()
                .map(|(i, param)| {
                    Instruction::mov(
                        Operand::Stack(i as i32 * -8 - 16, param.ty().width()),
                        param,
                    )
                }),
        )
        .chain(instructions.iter().flat_map(|i| {
            let v: Vec<_> = i.into();
            // v.insert(0, Instruction::Comment(format!("{i:?}")));
            v
        }))
        .collect();

    let alloc_stack = Instruction::AllocateStack(replace_pseudo(&mut v, symbols));
    v.insert(0, alloc_stack);
    v.into_iter().flat_map(fixup_instruction).collect()
}

fn fixup_instruction(instruction: Instruction) -> Vec<Instruction> {
    let vec = match instruction.clone() {
        Instruction::Move {
            source,
            destination,
        } if source.width() != destination.width() => {
            let source = match source {
                Operand::Immediate(v, _) => Operand::Immediate(v, destination.width()),
                Operand::Register(reg, _) => Operand::Register(reg, destination.width()),
                Operand::Psuedo(v, _) => Operand::Psuedo(v, destination.width()),
                Operand::Stack(v, _) => Operand::Stack(v, destination.width()),
                Operand::Data(v, _) => Operand::Data(v, destination.width()),
            };
            vec![Instruction::Move {
                source,
                destination,
            }]
        }
        Instruction::Move {
            source,
            destination,
        } if (matches!(source, Operand::Stack(_, _) | Operand::Data(_, _))
            || source.outside_int_range())
            && matches!(destination, Operand::Stack(_, _) | Operand::Data(_, _)) =>
        {
            vec![
                Instruction::mov(source, Reg::R10.width(destination.width())),
                Instruction::mov(Reg::R10.width(destination.width()), destination),
            ]
        }
        Instruction::Movesx {
            source,
            destination,
        } if matches!(source, Operand::Immediate(_, _))
            || matches!(destination, Operand::Stack(_, _) | Operand::Data(_, _)) =>
        {
            let tmp = Reg::R11.width(source.width());
            let tmp2 = Reg::R10.width(destination.width());
            vec![
                Instruction::mov(source, tmp.clone()),
                Instruction::Movesx {
                    source: tmp,
                    destination: tmp2.clone(),
                },
                Instruction::mov(tmp2, destination),
            ]
        }
        Instruction::Binary(op, src, dst)
            if matches!(op, BinaryOperator::LeftShift | BinaryOperator::RightShift)
                && matches!(src, Operand::Stack(_, _) | Operand::Data(_, _))
                && matches!(dst, Operand::Stack(_, _) | Operand::Data(_, _)) =>
        {
            vec![
                Instruction::mov(dst.clone(), Reg::R11.width(dst.width())),
                Instruction::mov(src.clone(), Reg::CX.width(Width::Four)),
                Instruction::binary(op, Reg::CX.word(), Reg::R11.width(dst.width())),
                Instruction::mov(Reg::R11.width(dst.width()), dst),
            ]
        }
        Instruction::Binary(op, src, dst)
            if (matches!(
                op,
                BinaryOperator::Mult | BinaryOperator::LeftShift | BinaryOperator::RightShift
            ) && matches!(dst, Operand::Stack(_, _) | Operand::Data(_, _))) =>
        {
            vec![
                Instruction::mov(dst.clone(), Reg::R11.width(dst.width())),
                Instruction::binary(op, src, Reg::R11.width(dst.width())),
                Instruction::mov(Reg::R11.width(dst.width()), dst),
            ]
        }
        Instruction::Binary(op, src, dst)
            if (matches!(src, Operand::Stack(_, _) | Operand::Data(_, _))
                && matches!(dst, Operand::Stack(_, _) | Operand::Data(_, _))
                && !matches!(op, BinaryOperator::LeftShift | BinaryOperator::RightShift))
                || src.outside_int_range() =>
        {
            vec![
                Instruction::mov(src.clone(), Reg::R10.width(dst.width())),
                Instruction::binary(op, Reg::R10.width(dst.width()), dst),
            ]
        }
        Instruction::Cmp(lhs, rhs) if lhs.outside_int_range() && rhs.outside_int_range() => {
            vec![
                Instruction::mov(lhs.clone(), Reg::R10.width(lhs.width())),
                Instruction::mov(rhs.clone(), Reg::R11.width(rhs.width())),
                Instruction::Cmp(Reg::R10.width(lhs.width()), Reg::R11.width(lhs.width())),
            ]
        }
        Instruction::Cmp(lhs, rhs)
            if (matches!(lhs, Operand::Stack(_, _) | Operand::Data(_, _))
                && matches!(rhs, Operand::Stack(_, _) | Operand::Data(_, _)))
                || lhs.outside_int_range() =>
        {
            vec![
                Instruction::mov(lhs, Reg::R10.width(rhs.width())),
                Instruction::Cmp(Reg::R10.width(rhs.width()), rhs),
            ]
        }
        Instruction::Cmp(lhs, rhs)
            if matches!(rhs, Operand::Immediate(_, _)) || rhs.outside_int_range() =>
        {
            vec![
                Instruction::mov(rhs.clone(), Reg::R11.width(rhs.width())),
                Instruction::Cmp(lhs.clone(), Reg::R11.width(lhs.width())),
            ]
        }
        Instruction::Push(op) if op.outside_int_range() => {
            let tmp = Reg::AX.width(op.width());
            vec![
                Instruction::mov(op, tmp.clone()),
                Instruction::Push(Reg::AX.width(Width::Eight)),
            ]
        }
        Instruction::Idiv(Operand::Immediate(val, width)) => {
            vec![
                Instruction::mov(Operand::Immediate(val, width), Reg::R10.width(width)),
                Instruction::Idiv(Reg::R10.width(width)),
            ]
        }

        i => return vec![i],
    };

    if vec.contains(&instruction) {
        panic!("{instruction:?} resolved to {vec:?}")
    }

    vec.into_iter().flat_map(fixup_instruction).collect()
}

pub fn generate_assembly(program: &tacky::Program, symbols: &SymbolTable) -> Program {
    let definitions = program
        .functions
        .iter()
        .map(|func| {
            let instructions = lower_instructions(&func.params, &func.instructions, symbols);
            Function {
                name: func.identifier.clone(),
                global: func.global,
                instructions,
            }
        })
        .collect();
    let mut static_variables: Vec<_> = program.static_variables.iter().map(|v| v.into()).collect();
    static_variables.sort_by(|lhs: &StaticVariable, rhs: &StaticVariable| lhs.name.cmp(&rhs.name));
    Program {
        definitions,
        static_variables,
    }
}
