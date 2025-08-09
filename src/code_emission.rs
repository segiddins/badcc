use std::io::{self, BufWriter, Write};

use crate::assembly_gen::*;

pub fn emit_asm(program: &Program, w: impl io::Write) -> io::Result<()> {
    let mut w = BufWriter::new(w);
    for definition in program.definitions.iter() {
        function_definition(definition, &mut w)?;
    }
    w.flush()
}

fn function_definition(function: &Function, mut w: impl io::Write) -> io::Result<()> {
    w.write_all(b"\t.globl ")?;

    #[cfg(target_os = "macos")]
    w.write_all(b"_")?;

    w.write_all(function.name.as_bytes())?;
    writeln!(w)?;

    #[cfg(target_os = "macos")]
    w.write_all(b"_")?;

    w.write_all(function.name.as_bytes())?;
    w.write_all(b":\n")?;
    w.write_all(b"\tpushq %rbp\n")?;
    w.write_all(b"\tmovq %rsp, %rbp\n")?;

    for inst in function.instructions.iter() {
        w.write_all(b"\t")?;
        instruction(inst, &mut w)?;
    }

    Ok(())
}

fn instruction(instruction: &Instruction, mut w: impl io::Write) -> io::Result<()> {
    match instruction {
        Instruction::Move {
            source,
            destination,
        } => write!(
            w,
            "mov{} {}, {}",
            width(source, destination),
            operand(source),
            operand(destination)
        )?,
        Instruction::Ret => write!(w, "movq %rbp, %rsp\n\tpopq %rbp\n\tret")?,
        Instruction::Unary(unary_operator, op) => match unary_operator {
            UnaryOperator::Neg => write!(w, "negl {}", operand(op)),
            UnaryOperator::Not => write!(w, "notl {}", operand(op)),
        }?,
        Instruction::AllocateStack(offset) => write!(w, "subq ${offset}, %rsp")?,
        Instruction::Binary(binary_operator, op, operand1) => match binary_operator {
            BinaryOperator::Add => write!(w, "addl {}, {}", operand(op), operand(operand1)),
            BinaryOperator::Sub => write!(w, "subl {}, {}", operand(op), operand(operand1)),
            BinaryOperator::Mult => write!(w, "imull {}, {}", operand(op), operand(operand1)),
            BinaryOperator::And => write!(w, "andl {}, {}", operand(op), operand(operand1)),
            BinaryOperator::Or => write!(w, "orl {}, {}", operand(op), operand(operand1)),
            BinaryOperator::Xor => write!(w, "xorl {}, {}", operand(op), operand(operand1)),
            BinaryOperator::LeftShift => write!(w, "sall {}, {}", operand(op), operand(operand1)),
            BinaryOperator::RightShift => write!(w, "sarl {}, {}", operand(op), operand(operand1)),
            BinaryOperator::Equals => todo!(),
            BinaryOperator::NotEquals => todo!(),
            BinaryOperator::LessThan => todo!(),
            BinaryOperator::LessThanOrEqual => todo!(),
            BinaryOperator::GreaterThan => todo!(),
            BinaryOperator::GreaterThanOrEqual => todo!(),
        }?,
        Instruction::Idiv(op) => write!(w, "idivl {}", operand(op))?,
        Instruction::Cdq => write!(w, "cdq")?,
        Instruction::Cmp(lhs, rhs) => write!(w, "cmpl {}, {}", operand(lhs), operand(rhs))?,
        Instruction::Jmp(label) => write!(w, "jmp L{label}")?,
        Instruction::JmpCC(cond_code, label) => write!(w, "j{cond_code:?} L{label}")?,
        Instruction::SetCC(cond_code, op) => write!(w, "set{cond_code:?} {}", operand(op))?,
        Instruction::Label(label) => write!(w, "L{label}:")?,
        Instruction::DeallocateStack(offset) => write!(w, "addq ${offset}, %rsp")?,
        Instruction::Push(op) => write!(w, "pushq {}", operand(op))?,
        Instruction::Call(func) => write!(w, "call _{func}")?,
    }
    writeln!(w)?;
    Ok(())
}

fn operand(operand: &Operand) -> String {
    match operand {
        Operand::Immediate(val) => format!("${val}"),
        Operand::Register(name, width) => match (name, width) {
            (Reg::AX, Width::One) => "%al",
            (Reg::AX, Width::Four) => "%eax",
            (Reg::AX, Width::Eight) => "%rax",
            (Reg::CX, Width::One) => "%cl",
            (Reg::CX, Width::Four) => "%ecx",
            (Reg::CX, Width::Eight) => "%rcx",
            (Reg::DI, Width::One) => "%dil",
            (Reg::DI, Width::Four) => "%edi",
            (Reg::DI, Width::Eight) => "%rdi",
            (Reg::DX, Width::One) => "%dl",
            (Reg::DX, Width::Four) => "%edx",
            (Reg::DX, Width::Eight) => "%rdx",
            (Reg::R10, Width::One) => "%r10b",
            (Reg::R10, Width::Four) => "%r10d",
            (Reg::R10, Width::Eight) => "%r10",
            (Reg::R11, Width::One) => "%r11b",
            (Reg::R11, Width::Four) => "%r11d",
            (Reg::R11, Width::Eight) => "%r11",
            (Reg::R8, Width::One) => "%r8b",
            (Reg::R8, Width::Four) => "%r8d",
            (Reg::R8, Width::Eight) => "%r8",
            (Reg::R9, Width::One) => "%r9b",
            (Reg::R9, Width::Four) => "%r9d",
            (Reg::R9, Width::Eight) => "%r9",
            (Reg::SI, Width::One) => "%sil",
            (Reg::SI, Width::Four) => "%esi",
            (Reg::SI, Width::Eight) => "%rsi",
        }
        .into(),
        Operand::Psuedo(_) => unreachable!(),
        Operand::Stack(offset) => format!("{}(%rbp)", -offset),
    }
}

fn width(op1: &Operand, op2: &Operand) -> &'static str {
    match op1.width().max(op2.width()) {
        Width::One => "w",
        Width::Four => "l",
        Width::Eight => "q",
    }
}
