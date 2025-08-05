use miette::{Context, IntoDiagnostic, Result};
use std::{
    fs::{self, File, read_to_string},
    io::Write,
    ops::Deref,
    path::{Path, PathBuf},
    process::Command,
};

use clap::Parser;

use crate::{
    assembly_gen::{Program, generate_assembly},
    code_emission::emit_asm,
    lexer::lex,
    parser::parse,
};

mod assembly_gen;
mod code_emission;
mod lexer;
mod parser;

struct OwnedPath(PathBuf);
impl Drop for OwnedPath {
    fn drop(&mut self) {
        let _ = fs::remove_file(&self.0);
    }
}

impl From<PathBuf> for OwnedPath {
    fn from(value: PathBuf) -> Self {
        Self(value)
    }
}

impl Deref for OwnedPath {
    type Target = PathBuf;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl AsRef<Path> for OwnedPath {
    fn as_ref(&self) -> &Path {
        self
    }
}

#[derive(clap::Parser)]
struct Driver {
    input: PathBuf,
    #[clap(short = 'o')]
    output: Option<PathBuf>,
    #[clap(long)]
    lex: bool,
    #[clap(long)]
    parse: bool,
    #[clap(long)]
    codegen: bool,
    #[clap(long)]
    validate: bool,
}

impl Driver {
    fn run(self) -> Result<()> {
        let pre = self.preprocess()?;

        let src = read_to_string(pre.as_ref())
            .into_diagnostic()
            .with_context(|| format!("failed to read {}", pre.display()))?;

        let tokens = lex(&src, pre.display().to_string())?;
        if self.lex {
            return Ok(());
        }

        let program = parse(src, &tokens, &pre.display().to_string())?;
        if self.parse {
            return Ok(());
        }

        let program = generate_assembly(&program);
        if self.codegen {
            return Ok(());
        }

        let assembly = self.emit_asm(&program)?;

        self.assemble(assembly)?;

        Ok(())
    }

    fn preprocess(&self) -> Result<OwnedPath> {
        let path = self.input.with_extension("i");
        Command::new("gcc")
            .arg("-E")
            .arg("-P")
            .arg(&self.input)
            .arg("-o")
            .arg(&path)
            .spawn()
            .into_diagnostic()?
            .wait()
            .into_diagnostic()?;
        Ok(path.into())
    }

    fn emit_asm(&self, program: &Program) -> Result<OwnedPath> {
        let path = self.input.with_extension("s");
        let mut f = File::create(&path).into_diagnostic()?;
        emit_asm(program, &f).into_diagnostic()?;
        f.flush().into_diagnostic()?;
        Ok(path.into())
    }

    fn assemble(&self, assembly: OwnedPath) -> Result<()> {
        Command::new("gcc")
            .arg(&assembly.0)
            .arg("-o")
            .arg(
                self.output
                    .clone()
                    .unwrap_or_else(|| self.input.with_extension("")),
            )
            .spawn()
            .into_diagnostic()?
            .wait()
            .into_diagnostic()?;

        Ok(())
    }
}

fn main() -> Result<()> {
    let driver = Driver::parse();

    driver.run()
}
