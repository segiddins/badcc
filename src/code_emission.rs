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
    }
    writeln!(w)?;
    Ok(())
}

fn operand(operand: &Operand) -> String {
    match operand {
        Operand::Immediate(val) => format!("${val}"),
        Operand::Register(name) => format!("%{}", name.as_ref()),
        Operand::Psuedo(offset) => format!("-{}(%rbp)", (offset + 1) * 4),
        Operand::Stack(_) => todo!(),
    }
}
