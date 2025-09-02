use std::io::{self, BufWriter, Write};

use crate::{assembly_gen::*, ast::Constant};

#[cfg(not(target_os = "macos"))]
const SYMBOL_PREFIX: &'static str = "";
#[cfg(target_os = "macos")]
const SYMBOL_PREFIX: &str = "_";

pub fn emit_asm(program: &Program, w: impl io::Write) -> io::Result<()> {
    let mut w = BufWriter::new(w);
    for sv in program.static_variables.iter() {
        if matches!(
            sv.value,
            Constant::UInt(0)
                | Constant::Int(0)
                | Constant::Long(0)
                | Constant::ULong(0)
                | Constant::Double(0.0)
        ) {
            symbol(sv.global, &sv.name, "bss", &mut w)?;
            writeln!(&mut w, "\t.zero {}\n", sv.alignment)?;
        } else if let Constant::Double(d) = sv.value {
            symbol(sv.global, &sv.name, "data", &mut w)?;
            writeln!(&mut w, "\t.quad 0x{:x}", d.to_bits())?;
        } else if sv.alignment == 4 {
            symbol(sv.global, &sv.name, "data", &mut w)?;
            writeln!(&mut w, "\t.long {}", sv.value.as_long())?;
        } else if sv.alignment == 8 {
            symbol(sv.global, &sv.name, "data", &mut w)?;
            writeln!(&mut w, "\t.quad {}", sv.value.as_long())?;
        } else {
            unreachable!()
        }
    }
    for definition in program.definitions.iter() {
        function_definition(definition, &mut w)?;
    }
    w.flush()
}

fn symbol(global: bool, name: &str, section: &str, mut w: impl io::Write) -> io::Result<()> {
    if global {
        w.write_all(b"\t.globl ")?;

        w.write_all(SYMBOL_PREFIX.as_bytes())?;

        w.write_all(name.as_bytes())?;
        writeln!(w)?;
    }

    w.write_all(b"\t.")?;
    w.write_all(section.as_bytes())?;
    w.write_all(b"\n")?;
    w.write_all(SYMBOL_PREFIX.as_bytes())?;
    w.write_all(name.as_bytes())?;
    w.write_all(b":\n")
}

fn function_definition(function: &Function, mut w: impl io::Write) -> io::Result<()> {
    symbol(function.global, &function.name, "text", &mut w)?;

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
            asm_type,
            source,
            destination,
        } => write!(
            w,
            "mov{} {}, {}",
            asm_type,
            operand(source),
            operand(destination)
        )?,
        Instruction::Movesx {
            source,
            destination,
        } => write!(w, "movslq {}, {}", operand(source), operand(destination))?,
        Instruction::Ret => write!(w, "movq %rbp, %rsp\n\tpopq %rbp\n\tret")?,
        Instruction::Unary(ty, unary_operator, op) => match unary_operator {
            UnaryOperator::Shr => write!(w, "shr{} {}", ty, operand(op)),
            UnaryOperator::Neg => write!(w, "neg{} {}", ty, operand(op)),
            UnaryOperator::Not => write!(w, "not{} {}", ty, operand(op)),
        }?,
        Instruction::AllocateStack(offset) => write!(w, "subq ${offset}, %rsp")?,
        Instruction::Binary(ty, binary_operator, op, operand1) => match binary_operator {
            BinaryOperator::Add => write!(w, "add{} {}, {}", ty, operand(op), operand(operand1)),
            BinaryOperator::Sub => write!(w, "sub{} {}, {}", ty, operand(op), operand(operand1)),
            BinaryOperator::Mult if ty == &AsmType::Double => {
                write!(w, "mul{} {}, {}", ty, operand(op), operand(operand1))
            }
            BinaryOperator::Mult => write!(w, "imul{} {}, {}", ty, operand(op), operand(operand1)),
            BinaryOperator::And => write!(w, "and{} {}, {}", ty, operand(op), operand(operand1)),
            BinaryOperator::Or => write!(w, "or{} {}, {}", ty, operand(op), operand(operand1)),
            BinaryOperator::Xor if *ty == AsmType::Double => {
                write!(w, "xorpd {}, {}", operand(op), operand(operand1))
            }
            BinaryOperator::Xor => write!(w, "xor{} {}, {}", ty, operand(op), operand(operand1)),
            BinaryOperator::SignedLeftShift => {
                write!(w, "sal{} {}, {}", ty, operand(op), operand(operand1))
            }
            BinaryOperator::SignedRightShift => {
                write!(w, "sar{} {}, {}", ty, operand(op), operand(operand1))
            }
            BinaryOperator::LeftShift => {
                write!(w, "shl{} {}, {}", ty, operand(op), operand(operand1))
            }
            BinaryOperator::RightShift => {
                write!(w, "shr{} {}, {}", ty, operand(op), operand(operand1))
            }
            BinaryOperator::DivDouble => todo!(),
            BinaryOperator::Equals
            | BinaryOperator::NotEquals
            | BinaryOperator::LessThan
            | BinaryOperator::LessThanOrEqual
            | BinaryOperator::GreaterThan
            | BinaryOperator::GreaterThanOrEqual => unreachable!(),
        }?,
        Instruction::Div(ty, op) => write!(w, "div{} {}", ty, operand(op))?,
        Instruction::Idiv(ty, op) => write!(w, "idiv{} {}", ty, operand(op))?,
        Instruction::Cdq(AsmType::Double) => unreachable!(),
        Instruction::Cdq(AsmType::Longword) => write!(w, "cdq")?,
        Instruction::Cdq(AsmType::Quadword) => write!(w, "cqo")?,
        Instruction::Cmp(AsmType::Double, lhs, rhs) => {
            write!(w, "comisd {}, {}", operand(lhs), operand(rhs))?
        }
        Instruction::Cmp(ty, lhs, rhs) => {
            write!(w, "cmp{} {}, {}", ty, operand(lhs), operand(rhs))?
        }
        Instruction::Jmp(label) => write!(w, "jmp L{label}")?,
        Instruction::JmpCC(cond_code, label) => write!(w, "j{cond_code:?} L{label}")?,
        Instruction::SetCC(cond_code, op) => write!(w, "set{cond_code:?} {}", operand(op))?,
        Instruction::Label(label) => write!(w, "L{label}:")?,
        Instruction::DeallocateStack(offset) => write!(w, "addq ${offset}, %rsp")?,
        Instruction::Push(op) => write!(w, "pushq {}", operand(op))?,
        Instruction::Call(func) => write!(w, "call _{func}")?,
        Instruction::Comment(comment) => write!(w, "# {comment}")?,
        Instruction::Cvtsi2sd { src_type, src, dst } => {
            write!(w, "cvtsi2sd{} {}, {}", src_type, operand(src), operand(dst))?
        }
        Instruction::Cvttsd2si { dst_type, src, dst } => write!(
            w,
            "cvttsd2si{} {}, {}",
            dst_type,
            operand(src),
            operand(dst)
        )?,
    }
    writeln!(w)?;
    Ok(())
}

fn operand(operand: &Operand) -> String {
    match operand {
        Operand::Immediate(val, _) => format!("${val}"),
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
            (Reg::XMM0, _) => "%xmm0",
            (Reg::XMM1, _) => "%xmm1",
            (Reg::XMM2, _) => "%xmm2",
            (Reg::XMM14, _) => "%xmm14",
            (Reg::XMM15, _) => "%xmm15",
            _ => todo!(),
        }
        .into(),
        Operand::Psuedo(_, _) => unreachable!(),
        Operand::Stack(offset, _) => format!("{}(%rbp)", -offset),
        Operand::Data(name, _) => format!("{SYMBOL_PREFIX}{name}(%rip)"),
    }
}
