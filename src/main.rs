#![feature(assert_matches)]

use miette::{Context, IntoDiagnostic, Result, bail};
use std::{
    fs::{File, read_to_string},
    io::Write,
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
mod tacky;

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

    #[clap(long, hide = true)]
    keep_artifacts: bool,

    #[clap(skip)]
    artifacts: Vec<PathBuf>,
}

impl Driver {
    fn run(mut self) -> Result<()> {
        let pre = self.preprocess()?;
        self.artifacts.push(pre.clone());

        let src = read_to_string(&pre)
            .into_diagnostic()
            .with_context(|| format!("failed to read {}", pre.display()))?;

        let tokens = lex(&src, pre.display().to_string())?;
        if self.lex {
            return Ok(());
        }

        let program = parse(src, tokens, &pre.display().to_string())?;
        if self.parse {
            return Ok(());
        }

        let tacky = tacky::lower(&program);

        let program = generate_assembly(&tacky);
        if self.codegen {
            return Ok(());
        }

        let assembly = self.emit_asm(&program)?;
        self.artifacts.push(assembly.clone());

        self.assemble(assembly).context("Assembling failed")?;

        Ok(())
    }

    fn preprocess(&self) -> Result<PathBuf> {
        let path = self.input.with_extension("i");
        let result = Command::new("gcc")
            .arg("-E")
            .arg("-P")
            .arg(&self.input)
            .arg("-o")
            .arg(&path)
            .spawn()
            .and_then(|mut c| c.wait())
            .into_diagnostic()?;
        if result.success() {
            Ok(path)
        } else {
            bail!("preprocessing {} failed", path.display())
        }
    }

    fn emit_asm(&self, program: &Program) -> Result<PathBuf> {
        let path = self.input.with_extension("s");
        let mut f = File::create(&path).into_diagnostic()?;
        emit_asm(program, &f).into_diagnostic()?;
        f.flush().into_diagnostic()?;
        Ok(path)
    }

    fn assemble(&self, assembly: impl AsRef<Path>) -> Result<()> {
        #[cfg(target_os = "macos")]
        let mut cmd = {
            let mut c = Command::new("arch");
            c.arg("-x86_64").arg("gcc");
            c
        };
        #[cfg(not(target_os = "macos"))]
        let mut cmd = Command::new("gcc");

        cmd.arg(assembly.as_ref()).arg("-o").arg(
            self.output
                .clone()
                .unwrap_or_else(|| self.input.with_extension("")),
        );

        let status = cmd.spawn().into_diagnostic()?.wait().into_diagnostic()?;

        if status.success() {
            Ok(())
        } else {
            bail!("{cmd:?}")
        }
    }
}

impl Drop for Driver {
    fn drop(&mut self) {
        if !self.keep_artifacts {
            for artifact in self.artifacts.drain(..) {
                let _ = std::fs::remove_file(artifact);
            }
        }
    }
}

fn main() -> Result<()> {
    let driver = Driver::parse();

    driver.run()
}
