use crate::tacky;

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
    Unary(UnaryOperator, Operand),
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
}

#[derive(Debug)]
pub enum UnaryOperator {
    Neg,
    Not,
}

#[derive(Debug, Clone, Copy)]
pub enum Operand {
    Immediate(i32),
    Register(Reg),
    Psuedo(u32),
    Stack(u32),
}

#[derive(Debug, Clone, Copy)]
pub enum Reg {
    AX,
    R10,
}

impl AsRef<str> for Reg {
    fn as_ref(&self) -> &'static str {
        match self {
            Reg::AX => "eax",
            Reg::R10 => "r10d",
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

impl From<&tacky::Instruction> for Vec<Instruction> {
    fn from(insn: &tacky::Instruction) -> Self {
        let mut insns: Vec<Instruction> = vec![];
        match insn {
            tacky::Instruction::Return(val) => {
                insns.push(Instruction::mov(val, Reg::AX));
                insns.push(Instruction::Ret);
            }
            tacky::Instruction::Unary { op, src, dst } => {
                insns.push(Instruction::mov(src, dst));
                insns.push(Instruction::unary(op, dst));
            }
        }
        insns
    }
}

fn replace_pseudo(instructions: impl Iterator<Item = Vec<Instruction>>) -> u32 {
    fn m(op: &Operand) -> u32 {
        match op {
            Operand::Immediate(_) => 0,
            Operand::Register(_) => 0,
            Operand::Psuedo(x) => *x,
            Operand::Stack(_) => unreachable!(),
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
            _ => vec![i],
        })
        .collect()
}

pub fn generate_assembly(program: &tacky::Program) -> Program {
    program.into()
}
