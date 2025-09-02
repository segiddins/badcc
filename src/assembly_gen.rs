use std::{collections::HashMap, fmt::Debug, iter::empty};

use crate::{
    ast::{self, Constant},
    sema::{Symbol, SymbolAttributes, SymbolTable, Type},
    tacky::{self, Val},
};

#[derive(Debug)]
pub struct Program {
    pub definitions: Vec<Function>,
    pub static_variables: Vec<StaticVariable>,
    pub static_constants: Vec<StaticConstant>,
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

    A,
    AE,
    B,
    BE,
}

#[derive(Debug, PartialEq, Eq, Clone)]
pub enum Instruction {
    Move {
        asm_type: AsmType,
        source: Operand,
        destination: Operand,
    },
    Movesx {
        source: Operand,
        destination: Operand,
    },
    Unary(AsmType, UnaryOperator, Operand),
    Binary(AsmType, BinaryOperator, Operand, Operand),
    Cmp(AsmType, Operand, Operand),
    Idiv(AsmType, Operand),
    Div(AsmType, Operand),
    Cdq(AsmType),
    Jmp(String),
    JmpCC(CondCode, String),
    SetCC(CondCode, Operand),
    Label(String),
    AllocateStack(u32),
    DeallocateStack(u32),
    Push(Operand),
    Call(String),
    Comment(String),
    Cvtsi2sd {
        src_type: AsmType,
        src: Operand,
        dst: Operand,
    },
    Cvttsd2si {
        dst_type: AsmType,
        src: Operand,
        dst: Operand,
    },
    Ret,
}

trait IntoOperand {
    fn into_operand(&self) -> (Operand, AsmType);
}

impl<T: IntoOperand> From<T> for Operand {
    fn from(value: T) -> Self {
        let (o, _) = value.into_operand();
        o
    }
}

impl Instruction {
    fn mov(src: impl IntoOperand, dst: impl Into<Operand>) -> Self {
        let (source, asm_type) = src.into_operand();
        Self::Move {
            asm_type,
            source,
            destination: dst.into(),
        }
    }

    fn unary(op: impl Into<UnaryOperator>, dst: impl IntoOperand) -> Self {
        let (dst, ty) = dst.into_operand();
        Self::Unary(ty, op.into(), dst)
    }

    fn binary(
        op: impl Into<BinaryOperator>,
        lhs: impl Into<Operand>,
        rhs: impl IntoOperand,
    ) -> Self {
        let (rhs, ty) = rhs.into_operand();
        Self::Binary(ty, op.into(), lhs.into(), rhs)
    }

    fn cmp(lhs: impl Into<Operand>, rhs: impl IntoOperand) -> Self {
        let (rhs, ty) = rhs.into_operand();
        Self::Cmp(ty, lhs.into(), rhs)
    }
    fn div(operand: impl IntoOperand) -> Self {
        let (rhs, ty) = operand.into_operand();
        Self::Div(ty, rhs)
    }
    fn idiv(operand: impl IntoOperand) -> Self {
        let (rhs, ty) = operand.into_operand();
        Self::Idiv(ty, rhs)
    }
}

impl From<&Type> for AsmType {
    fn from(value: &Type) -> Self {
        match value {
            Type::Function { .. } => AsmType::Quadword,
            Type::Int | Type::UInt => AsmType::Longword,
            Type::Long | Type::ULong => AsmType::Quadword,
            Type::Double => AsmType::Double,
        }
    }
}
impl std::fmt::Display for AsmType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            AsmType::Longword => write!(f, "l"),
            AsmType::Quadword => write!(f, "q"),
            AsmType::Double => write!(f, "sd"),
        }
    }
}
impl From<Type> for AsmType {
    fn from(value: Type) -> Self {
        (&value).into()
    }
}

impl IntoOperand for &Val {
    fn into_operand(&self) -> (Operand, AsmType) {
        let asm_type = self.ty().into();
        let op = match self {
            tacky::Val::Constant(c) => match c {
                ast::Constant::Int(_) | ast::Constant::UInt(_) => {
                    Operand::Immediate(c.as_long(), Width::Four)
                }
                ast::Constant::Long(_) | ast::Constant::ULong(_) => {
                    Operand::Immediate(c.as_long(), Width::Eight)
                }
                ast::Constant::Double(d) => Operand::Immediate(d.to_bits() as i64, Width::Eight),
            },
            tacky::Val::Var(id, ty) => Operand::Psuedo(id.clone(), ty.width()),
        };
        (op, asm_type)
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum AsmType {
    Longword,
    Quadword,
    Double,
}

#[derive(Debug, PartialEq, Eq, Clone)]
pub enum UnaryOperator {
    Neg,
    Not,
    Shr,
}
#[derive(Debug, PartialEq, Eq, Clone)]
pub enum BinaryOperator {
    Add,
    Sub,
    Mult,
    And,
    Or,
    Xor,
    SignedLeftShift,
    SignedRightShift,
    LeftShift,
    RightShift,
    Equals,
    NotEquals,
    LessThan,
    LessThanOrEqual,
    GreaterThan,
    GreaterThanOrEqual,
    DivDouble,
}

#[derive(Clone, PartialEq, Eq)]
pub enum Operand {
    Immediate(i64, Width),
    Register(Reg, Width),
    Psuedo(String, Width),
    Stack(i32, Width),
    Data(String, Width),
}

impl Debug for Operand {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Immediate(arg0, arg1) => {
                write!(f, "Immediate({arg0}, {arg1:?})")
            }
            Self::Register(arg0, arg1) => {
                write!(f, "Register({arg0:?}, {arg1:?})")
            }
            Self::Psuedo(arg0, arg1) => write!(f, "Psuedo({arg0:?}, {arg1:?})"),
            Self::Stack(arg0, arg1) => write!(f, "Stack({arg0:?}, {arg1:?})"),
            Self::Data(arg0, arg1) => write!(f, "Data({arg0:?}, {arg1:?})"),
        }
    }
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
    XMM0,
    XMM1,
    XMM2,
    XMM3,
    XMM4,
    XMM5,
    XMM6,
    XMM7,
    XMM14,
    XMM15,
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
    pub value: Constant,
    pub alignment: i32,
}

#[derive(Debug)]
pub struct StaticConstant {
    pub name: String,
    pub value: Constant,
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
            tacky::BinaryOperator::LeftShift => Self::SignedLeftShift,
            tacky::BinaryOperator::RightShift => Self::SignedRightShift,
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

impl tacky::BinaryOperator {
    fn cond_code(&self, ty: &Type) -> CondCode {
        use CondCode::*;
        use tacky::BinaryOperator::*;
        match (self, ty.signed()) {
            (Equals, _) => E,
            (NotEqual, _) => NE,
            (LessThan, true) => L,
            (LessThan, false) => B,
            (LessThanOrEqual, true) => LE,
            (LessThanOrEqual, false) => BE,
            (GreaterThan, true) => G,
            (GreaterThan, false) => A,
            (GreaterThanOrEqual, true) => GE,
            (GreaterThanOrEqual, false) => AE,
            (Or | And, _) => NE,
            value => unreachable!("{value:?} is not a valid CondCode"),
        }
    }
}

impl IntoOperand for (i64, Width) {
    fn into_operand(&self) -> (Operand, AsmType) {
        let (i, w) = self;
        (
            Operand::Immediate(*i, *w),
            match w {
                Width::One => unreachable!(),
                Width::Four => AsmType::Longword,
                Width::Eight => AsmType::Quadword,
            },
        )
    }
}

impl IntoOperand for (Reg, Width) {
    fn into_operand(&self) -> (Operand, AsmType) {
        use Reg::*;
        use Width::*;

        match (self.0, self.1) {
            (XMM0 | XMM1 | XMM2 | XMM3 | XMM4 | XMM5 | XMM6 | XMM7 | XMM14 | XMM15, _) => {
                (Operand::Register(self.0, Eight), AsmType::Double)
            }
            (_, Four) => (Operand::Register(self.0, Four), AsmType::Longword),
            (_, Eight) => (Operand::Register(self.0, Eight), AsmType::Quadword),
            (_, One) => unreachable!(),
        }
    }
}

const REG_ARGS: [Reg; 6] = [Reg::DI, Reg::SI, Reg::DX, Reg::CX, Reg::R8, Reg::R9];
const XMM_REG_ARGS: [Reg; 8] = [
    Reg::XMM0,
    Reg::XMM1,
    Reg::XMM2,
    Reg::XMM3,
    Reg::XMM4,
    Reg::XMM5,
    Reg::XMM6,
    Reg::XMM7,
];

impl From<&tacky::Instruction> for Vec<Instruction> {
    fn from(insn: &tacky::Instruction) -> Self {
        match insn {
            tacky::Instruction::Return(val) if matches!(val.ty(), Type::Double) => {
                vec![
                    Instruction::mov(val, Reg::XMM0.width(val.ty().width())),
                    Instruction::Ret,
                ]
            }
            tacky::Instruction::Return(val) => {
                vec![
                    Instruction::mov(val, Reg::AX.width(val.ty().width())),
                    Instruction::Ret,
                ]
            }
            tacky::Instruction::Unary { op, src, dst } => match op {
                tacky::UnaryOperator::Not => {
                    vec![
                        Instruction::cmp((0, src.ty().width()), src),
                        Instruction::mov((0, dst.ty().width()), dst),
                        Instruction::SetCC(CondCode::E, dst.into()),
                    ]
                }
                tacky::UnaryOperator::Negate if src.ty() == Type::Double => {
                    vec![
                        Instruction::mov(src, dst),
                        Instruction::Binary(
                            AsmType::Quadword,
                            BinaryOperator::Xor,
                            (&tacky::Val::Constant(Constant::Double(-0.0))).into(),
                            dst.into(),
                        ),
                    ]
                }
                op => vec![Instruction::mov(src, dst), Instruction::unary(op, dst)],
            },
            tacky::Instruction::Binary { op, lhs, rhs, dst } => match op {
                tacky::BinaryOperator::Divide if dst.ty().signed() => {
                    vec![
                        Instruction::mov(lhs, Reg::AX.width(lhs.ty().width())),
                        Instruction::Cdq(lhs.ty().into()),
                        Instruction::Idiv(rhs.ty().into(), rhs.into()),
                        Instruction::Move {
                            asm_type: rhs.ty().into(),
                            source: Reg::AX.width(lhs.ty().width()),
                            destination: dst.into(),
                        },
                    ]
                }
                // unsigned
                tacky::BinaryOperator::Divide => {
                    vec![
                        Instruction::mov(lhs, Reg::AX.width(lhs.ty().width())),
                        Instruction::mov((0, lhs.ty().width()), Reg::DX.width(lhs.ty().width())),
                        Instruction::div(rhs),
                        Instruction::mov((Reg::AX, dst.ty().width()), dst),
                    ]
                }
                tacky::BinaryOperator::Remainder if dst.ty().signed() => {
                    vec![
                        Instruction::mov(lhs, Reg::AX.width(lhs.ty().width())),
                        Instruction::Cdq(lhs.ty().into()),
                        Instruction::idiv(rhs),
                        Instruction::mov((Reg::DX, dst.ty().width()), dst),
                    ]
                }
                // unsigned
                tacky::BinaryOperator::Remainder => {
                    vec![
                        Instruction::mov(lhs, Reg::AX.width(lhs.ty().width())),
                        Instruction::mov((0, lhs.ty().width()), Reg::DX.width(lhs.ty().width())),
                        Instruction::div(rhs),
                        Instruction::mov((Reg::DX, dst.ty().width()), dst),
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
                        Instruction::cmp(rhs, lhs),
                        Instruction::mov((0, dst.ty().width()), dst),
                        Instruction::SetCC(op.cond_code(&dst.ty()), dst.into()),
                    ]
                }
                tacky::BinaryOperator::LeftShift if !lhs.ty().signed() => {
                    vec![
                        Instruction::mov(lhs, dst),
                        Instruction::binary(BinaryOperator::LeftShift, rhs, dst),
                    ]
                }
                tacky::BinaryOperator::RightShift if !lhs.ty().signed() => {
                    vec![
                        Instruction::mov(lhs, dst),
                        Instruction::binary(BinaryOperator::RightShift, rhs, dst),
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
                Instruction::cmp(Operand::Immediate(0, Width::Four), val),
                Instruction::JmpCC(CondCode::E, target.into()),
            ],
            tacky::Instruction::JumpIfNotZero(val, target) => vec![
                Instruction::cmp(Operand::Immediate(0, Width::Four), val),
                Instruction::JmpCC(CondCode::NE, target.into()),
            ],
            tacky::Instruction::Label(label) => vec![Instruction::Label(label.clone())],
            tacky::Instruction::Call(func, args, ret) => {
                let mut instructions = vec![];

                let mut gen_reg_args = vec![];
                let mut xmm_reg_args = vec![];
                let mut stack_args = vec![];

                for arg in args.iter() {
                    match arg.ty() {
                        Type::Function { .. }
                        | Type::Int
                        | Type::Long
                        | Type::UInt
                        | Type::ULong => {
                            if gen_reg_args.len() == REG_ARGS.len() {
                                stack_args.push(arg);
                            } else {
                                gen_reg_args.push(arg);
                            }
                        }
                        Type::Double => {
                            if xmm_reg_args.len() == XMM_REG_ARGS.len() {
                                stack_args.push(arg);
                            } else {
                                xmm_reg_args.push(arg);
                            }
                        }
                    }
                }

                stack_args.reverse();
                let stack_args_len = stack_args.len() as u32;
                let stack_padding = (stack_args_len * 8) % 16;
                if !stack_padding.is_multiple_of(16) {
                    instructions.push(Instruction::AllocateStack(stack_padding))
                };

                for (param, reg) in gen_reg_args.into_iter().zip(&REG_ARGS) {
                    instructions.push(Instruction::mov(param, reg.width(param.ty().width())));
                }
                for (param, reg) in xmm_reg_args.into_iter().zip(&XMM_REG_ARGS) {
                    instructions.push(Instruction::mov(param, reg.width(param.ty().width())));
                }

                for param in stack_args {
                    let (param, asm_type) = param.into_operand();
                    match param {
                        Operand::Immediate(_, _) | Operand::Register(_, _) => {
                            instructions.push(Instruction::Push(param));
                        }
                        Operand::Psuedo(_, width) | Operand::Data(_, width) => {
                            instructions.push(Instruction::Move {
                                asm_type,
                                source: param,
                                destination: Reg::AX.width(width),
                            });
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

                let reg = match ret.ty() {
                    Type::Double => (Reg::XMM0, ret.ty().width()),
                    _ => (Reg::AX, ret.ty().width()),
                };
                instructions.push(Instruction::mov(reg, ret));
                instructions
            }
            tacky::Instruction::SignExtend { src, dst } => vec![Instruction::Movesx {
                source: src.into(),
                destination: dst.into(),
            }],
            tacky::Instruction::Truncate { src, dst } => vec![Instruction::Move {
                asm_type: dst.ty().into(),
                source: match src {
                    tacky::Val::Constant(constant) => {
                        Operand::Immediate(constant.as_long() as i32 as i64, dst.ty().width())
                    }
                    tacky::Val::Var(name, _) => Operand::Psuedo(name.clone(), dst.ty().width()),
                },
                destination: dst.into(),
            }],

            tacky::Instruction::ZeroExtend { src, dst } => {
                vec![
                    Instruction::mov(src, Reg::R11.width(src.ty().width())),
                    Instruction::mov((Reg::R11, dst.ty().width()), dst),
                ]
            }
            tacky::Instruction::DoubleToInt { src, dst } => {
                let (dst, dst_type) = dst.into_operand();
                vec![Instruction::Cvttsd2si {
                    dst_type,
                    src: src.into(),
                    dst,
                }]
            }
            tacky::Instruction::DoubleToUInt { src, dst } if dst.ty() == Type::UInt => {
                let tmp = mktmp(AsmType::Quadword, true);
                vec![
                    Instruction::Cvttsd2si {
                        dst_type: AsmType::Quadword,
                        src: src.into(),
                        dst: tmp.clone(),
                    },
                    Instruction::Move {
                        asm_type: AsmType::Longword,
                        source: tmp,
                        destination: dst.into(),
                    },
                ]
            }
            tacky::Instruction::DoubleToUInt { src, dst } => {
                let tmp = mktmp(AsmType::Quadword, true);
                vec![
                    Instruction::Cvttsd2si {
                        dst_type: AsmType::Quadword,
                        src: src.into(),
                        dst: tmp.clone(),
                    },
                    Instruction::Move {
                        asm_type: AsmType::Longword,
                        source: tmp,
                        destination: dst.into(),
                    },
                ]
            }
            tacky::Instruction::IntToDouble { src, dst } => {
                let (src, src_type) = src.into_operand();
                vec![Instruction::Cvtsi2sd {
                    src_type,
                    src,
                    dst: dst.into(),
                }]
            }
            tacky::Instruction::UIntToDouble { src, dst } => todo!(),
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
                asm_type: _,
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
            Instruction::Unary(_, _, operand) => m(operand),
            Instruction::Binary(_, _, operand, operand1) => {
                m(operand);
                m(operand1);
            }
            Instruction::Idiv(_, operand) | Instruction::Div(_, operand) => m(operand),
            Instruction::Cmp(_, operand, operand1) => {
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
            Instruction::Cvtsi2sd {
                src_type: _,
                src,
                dst,
            }
            | Instruction::Cvttsd2si {
                dst_type: _,
                src,
                dst,
            } => {
                m(src);
                m(dst);
            }
        }
    }
    (max as u32).next_multiple_of(16)
}

fn lower_instructions(
    params: &[tacky::Val],
    instructions: &[tacky::Instruction],
    symbols: &SymbolTable,
) -> Vec<Instruction> {
    let mut gen_reg_args = vec![];
    let mut xmm_reg_args = vec![];
    let mut stack_args = vec![];

    for arg in params.iter() {
        match arg.ty() {
            Type::Function { .. } | Type::Int | Type::Long | Type::UInt | Type::ULong => {
                if gen_reg_args.len() == REG_ARGS.len() {
                    stack_args.push(arg);
                } else {
                    gen_reg_args.push(arg);
                }
            }
            Type::Double => {
                if xmm_reg_args.len() == XMM_REG_ARGS.len() {
                    stack_args.push(arg);
                } else {
                    xmm_reg_args.push(arg);
                }
            }
        }
    }

    let mut v: Vec<Instruction> = empty()
        .chain(
            gen_reg_args
                .into_iter()
                .zip(REG_ARGS)
                .map(|(var, reg)| Instruction::mov((reg, var.ty().width()), var)),
        )
        .chain(
            xmm_reg_args
                .into_iter()
                .zip(XMM_REG_ARGS)
                .map(|(var, reg)| Instruction::mov((reg, var.ty().width()), var)),
        )
        .chain(
            stack_args
                .into_iter()
                .enumerate()
                .map(|(i, param)| Instruction::Move {
                    asm_type: param.ty().into(),
                    source: Operand::Stack(i as i32 * -8 - 16, param.ty().width()),
                    destination: param.into(),
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

fn mktmp(asm_type: AsmType, is_dest: bool) -> Operand {
    match (asm_type, is_dest) {
        (AsmType::Longword, true) => Reg::R10.width(Width::Four),
        (AsmType::Longword, false) => Reg::R11.width(Width::Four),
        (AsmType::Quadword, true) => Reg::R10.width(Width::Eight),
        (AsmType::Quadword, false) => Reg::R11.width(Width::Eight),
        (AsmType::Double, true) => Reg::XMM14.width(Width::Eight),
        (AsmType::Double, false) => Reg::XMM15.width(Width::Eight),
    }
}

fn fixup_instruction(instruction: Instruction) -> Vec<Instruction> {
    let vec = match instruction.clone() {
        Instruction::Move {
            asm_type: AsmType::Double,
            source,
            destination,
        } if matches!(source, Operand::Immediate(_, _)) => {
            let tmp = Reg::R10.width(Width::Eight);
            vec![
                Instruction::Move {
                    asm_type: AsmType::Quadword,
                    source,
                    destination: tmp.clone(),
                },
                Instruction::Move {
                    asm_type: AsmType::Quadword,
                    source: tmp.clone(),
                    destination,
                },
            ]
        }
        Instruction::Move {
            asm_type,
            source,
            destination,
        } if (matches!(source, Operand::Stack(_, _) | Operand::Data(_, _))
            || source.outside_int_range())
            && matches!(destination, Operand::Stack(_, _) | Operand::Data(_, _)) =>
        {
            let tmp = mktmp(asm_type, true);
            vec![
                Instruction::Move {
                    asm_type,
                    source,
                    destination: tmp.clone(),
                },
                Instruction::Move {
                    asm_type,
                    source: tmp,
                    destination,
                },
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
                Instruction::Move {
                    asm_type: AsmType::Longword,
                    source,
                    destination: tmp.clone(),
                },
                Instruction::Movesx {
                    source: tmp,
                    destination: tmp2.clone(),
                },
                Instruction::Move {
                    asm_type: AsmType::Quadword,
                    source: tmp2,
                    destination,
                },
            ]
        }
        Instruction::Binary(asm_type, op, src, dst)
            if matches!(
                op,
                BinaryOperator::SignedLeftShift
                    | BinaryOperator::SignedRightShift
                    | BinaryOperator::LeftShift
                    | BinaryOperator::RightShift
            ) && matches!(src, Operand::Stack(_, _) | Operand::Data(_, _))
                && matches!(dst, Operand::Stack(_, _) | Operand::Data(_, _)) =>
        {
            let tmp = mktmp(asm_type, false);
            vec![
                Instruction::Move {
                    asm_type,
                    source: dst.clone(),
                    destination: tmp.clone(),
                },
                Instruction::Move {
                    asm_type,
                    source: src,
                    destination: Reg::CX.width(dst.width()),
                },
                Instruction::Binary(asm_type, op, Reg::CX.word(), tmp.clone()),
                Instruction::Move {
                    asm_type,
                    source: tmp,
                    destination: dst,
                },
            ]
        }
        Instruction::Binary(asm_type, op, src, dst)
            if (matches!(
                op,
                BinaryOperator::Mult
                    | BinaryOperator::SignedLeftShift
                    | BinaryOperator::SignedRightShift
                    | BinaryOperator::LeftShift
                    | BinaryOperator::RightShift
            ) && matches!(dst, Operand::Stack(_, _) | Operand::Data(_, _)))
                || (matches!(asm_type, AsmType::Double)
                    && !matches!(dst, Operand::Register(_, _))) =>
        {
            let tmp = mktmp(asm_type, false);
            vec![
                Instruction::Move {
                    asm_type,
                    source: dst.clone(),
                    destination: tmp.clone(),
                },
                Instruction::Binary(asm_type, op, src, tmp.clone()),
                Instruction::Move {
                    asm_type,
                    source: tmp,
                    destination: dst,
                },
            ]
        }
        Instruction::Binary(asm_type, op, src, dst)
            if (matches!(src, Operand::Stack(_, _) | Operand::Data(_, _))
                && matches!(dst, Operand::Stack(_, _) | Operand::Data(_, _))
                && !matches!(
                    op,
                    BinaryOperator::SignedLeftShift
                        | BinaryOperator::SignedRightShift
                        | BinaryOperator::LeftShift
                        | BinaryOperator::RightShift
                ))
                || src.outside_int_range() =>
        {
            let tmp = mktmp(asm_type, true);
            vec![
                Instruction::Move {
                    asm_type,
                    source: src,
                    destination: tmp.clone(),
                },
                Instruction::Binary(asm_type, op, tmp, dst),
            ]
        }
        Instruction::Cmp(asm_type, lhs, rhs)
            if lhs.outside_int_range() && rhs.outside_int_range() =>
        {
            let tmp1 = mktmp(asm_type, true);
            let tmp2 = mktmp(asm_type, false);
            vec![
                Instruction::Move {
                    asm_type,
                    source: lhs.clone(),
                    destination: tmp1.clone(),
                },
                Instruction::Move {
                    asm_type,
                    source: rhs.clone(),
                    destination: tmp2.clone(),
                },
                Instruction::Cmp(asm_type, tmp1, tmp2),
            ]
        }
        Instruction::Cmp(asm_type, lhs, rhs)
            if (matches!(lhs, Operand::Stack(_, _) | Operand::Data(_, _))
                && matches!(rhs, Operand::Stack(_, _) | Operand::Data(_, _)))
                || lhs.outside_int_range()
                || (asm_type == AsmType::Double && matches!(lhs, Operand::Immediate(_, _))) =>
        {
            let tmp = mktmp(asm_type, true);
            vec![
                Instruction::Move {
                    asm_type,
                    source: lhs,
                    destination: tmp.clone(),
                },
                Instruction::Cmp(asm_type, tmp, rhs),
            ]
        }
        Instruction::Cmp(asm_type, lhs, rhs)
            if matches!(rhs, Operand::Immediate(_, _))
                || rhs.outside_int_range()
                || (asm_type == AsmType::Double && !matches!(rhs, Operand::Register(_, _))) =>
        {
            let tmp = mktmp(asm_type, false);
            vec![
                Instruction::Move {
                    asm_type,
                    source: rhs.clone(),
                    destination: tmp.clone(),
                },
                Instruction::Cmp(asm_type, lhs.clone(), tmp),
            ]
        }
        Instruction::Push(op) if op.outside_int_range() => {
            let tmp = Reg::AX.width(op.width());
            vec![
                Instruction::Move {
                    asm_type: match op.width() {
                        Width::One => unreachable!(),
                        Width::Four => AsmType::Longword,
                        Width::Eight => AsmType::Quadword,
                    },
                    source: op,
                    destination: tmp,
                },
                Instruction::Push(Reg::AX.width(Width::Eight)),
            ]
        }
        Instruction::Idiv(asm_type, Operand::Immediate(val, width)) => {
            vec![
                Instruction::Move {
                    asm_type,
                    source: Operand::Immediate(val, width),
                    destination: Reg::R10.width(width),
                },
                Instruction::Idiv(asm_type, Reg::R10.width(width)),
            ]
        }
        Instruction::Div(asm_type, Operand::Immediate(val, width)) => {
            vec![
                Instruction::Move {
                    asm_type,
                    source: Operand::Immediate(val, width),
                    destination: Reg::R10.width(width),
                },
                Instruction::Div(asm_type, Reg::R10.width(width)),
            ]
        }
        Instruction::Cvttsd2si { dst_type, src, dst }
            if !matches!(dst, Operand::Register(_, _)) =>
        {
            let tmp = mktmp(dst_type, false);
            vec![
                Instruction::Cvttsd2si {
                    dst_type,
                    src,
                    dst: tmp.clone(),
                },
                Instruction::Move {
                    asm_type: dst_type,
                    source: tmp,
                    destination: dst,
                },
            ]
        }

        Instruction::Cvtsi2sd { src_type, src, dst }
            if matches!(src, Operand::Immediate(_, _))
                || !matches!(dst, Operand::Register(_, _)) =>
        {
            vec![
                Instruction::Move {
                    asm_type: src_type,
                    source: src.clone(),
                    destination: Reg::R10.width(src.width()),
                },
                Instruction::Cvtsi2sd {
                    src_type,
                    src: Reg::R10.width(src.width()),
                    dst: Reg::XMM15.width(dst.width()),
                },
                Instruction::Move {
                    asm_type: src_type,
                    source: Reg::XMM15.width(dst.width()),
                    destination: dst,
                },
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
        static_constants: vec![],
    }
}
