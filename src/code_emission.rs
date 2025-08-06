use std::io::{self, BufWriter, Write};

use crate::assembly_gen::*;

pub fn emit_asm(program: &Program, w: impl io::Write) -> io::Result<()> {
    let mut w = BufWriter::new(w);
    function_definition(&program.function_definition, &mut w)?;
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
        } => write!(w, "movl {}, {}", operand(source), operand(destination))?,
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
            BinaryOperator::LeftShift => write!(
                w,
                "sall {}, {}",
                match op {
                    Operand::Register(Reg::CL) => "%cl".to_string(),
                    op => operand(op),
                },
                operand(operand1)
            ),
            BinaryOperator::RightShift => write!(
                w,
                "sarl {}, {}",
                match op {
                    Operand::Register(Reg::CL) => "%cl".to_string(),
                    op => operand(op),
                },
                operand(operand1)
            ),
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
    }
    writeln!(w)?;
    Ok(())
}

fn operand(operand: &Operand) -> String {
    match operand {
        Operand::Immediate(val) => format!("${val}"),
        Operand::Register(name) => format!("%{}", name.as_ref()),
        Operand::Psuedo(offset) => format!("-{}(%rbp)", (offset + 1) * 4),
    }
}
