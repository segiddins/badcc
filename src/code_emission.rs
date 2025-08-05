use std::io::{self, BufWriter, Write};

use crate::assembly_gen::*;

pub fn emit_asm(program: &Program, w: impl io::Write) -> io::Result<()> {
    let mut w = BufWriter::new(w);
    function_definition(&program.function_definition, &mut w)?;
    w.flush()
}

fn function_definition(function: &Function, mut w: impl io::Write) -> io::Result<()> {
    w.write_all(b".globl ")?;

    #[cfg(target_os = "macos")]
    w.write_all(b"_")?;

    w.write_all(function.name.as_bytes())?;
    writeln!(w)?;

    #[cfg(target_os = "macos")]
    w.write_all(b"_")?;

    w.write_all(function.name.as_bytes())?;
    w.write_all(b":\n")?;

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
        Instruction::Ret => write!(w, "ret")?,
    }
    writeln!(w)?;
    Ok(())
}

fn operand(operand: &Operand) -> String {
    match operand {
        Operand::Immediate(val) => format!("${val}"),
        Operand::Register => "%eax".to_string(),
    }
}
