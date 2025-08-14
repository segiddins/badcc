#![feature(assert_matches)]

use camino::{Utf8Path, Utf8PathBuf};
use fs_err::{File, create_dir_all, read_to_string};
use miette::{Context, IntoDiagnostic, Result, bail};
use std::{io::Write, process::Command};

use clap::Parser;

use crate::{
    assembly_gen::{Program, generate_assembly},
    code_emission::emit_asm,
    lexer::lex,
    parser::parse,
    sema::validate,
};

mod assembly_gen;
mod code_emission;
mod lexer;
mod parser;
mod sema;
mod tacky;

#[derive(clap::Parser)]
struct Driver {
    input: Utf8PathBuf,
    #[clap(short = 'o')]
    output: Option<Utf8PathBuf>,
    #[clap(long)]
    lex: bool,
    #[clap(long)]
    parse: bool,
    #[clap(long)]
    codegen: bool,
    #[clap(long)]
    validate: bool,

    #[clap(long, hide = true)]
    test_output_dir: Option<Utf8PathBuf>,

    #[clap(long)]
    tacky: bool,

    #[clap(short = 'c', help = "Only run preprocess, compile, and assemble steps")]
    skip_linking: bool,

    #[clap(long, hide = true)]
    print_ast: bool,

    #[clap(long, hide = true)]
    keep_artifacts: bool,

    #[clap(skip)]
    artifacts: Vec<Utf8PathBuf>,
}

impl Driver {
    fn run(&mut self) -> Result<()> {
        let pre = self.preprocess()?;
        self.artifacts.push(pre.clone());

        let src = read_to_string(&pre)
            .into_diagnostic()
            .with_context(|| format!("failed to read {}", pre))?;

        let tokens = lex(&src, &pre)?;
        self.write_test_output("tokens", || {
            format!("{:#?}", tokens.iter().map(|(t, _)| t).collect::<Vec<_>>())
        });
        if self.lex {
            return Ok(());
        }

        let mut program = parse(src, tokens, pre.as_str())?;
        if self.parse {
            return Ok(());
        }
        self.write_test_output("ast", || format!("{program:#?}"));

        if self.print_ast {
            println!("{program:#?}");
        }

        validate(&mut program)?;
        self.write_test_output("sema_ast", || format!("{program:#?}"));
        if self.validate {
            return Ok(());
        }

        let tacky = tacky::lower(&program);
        self.write_test_output("tacky", || format!("{tacky:#?}"));

        if self.tacky {
            return Ok(());
        }

        let program = generate_assembly(&tacky);
        self.write_test_output("assembly_ast", || format!("{program:#?}"));
        if self.codegen {
            return Ok(());
        }

        let assembly = self.emit_asm(&program)?;
        self.artifacts.push(assembly.clone());

        self.assemble(assembly).context("Assembling failed")?;

        Ok(())
    }

    fn preprocess(&self) -> Result<Utf8PathBuf> {
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
            bail!("preprocessing {} failed", path)
        }
    }

    fn emit_asm(&self, program: &Program) -> Result<Utf8PathBuf> {
        let path = self.input.with_extension("s");
        let mut f = File::create(&path).into_diagnostic()?;
        emit_asm(program, &f).into_diagnostic()?;
        f.flush().into_diagnostic()?;
        self.write_test_output("assembly.s", || read_to_string(&path).unwrap());
        Ok(path)
    }

    fn assemble(&self, assembly: impl AsRef<Utf8Path>) -> Result<()> {
        #[cfg(target_os = "macos")]
        let mut cmd = {
            let mut c = Command::new("arch");
            c.arg("-x86_64").arg("gcc");
            c
        };
        #[cfg(not(target_os = "macos"))]
        let mut cmd = Command::new("gcc");

        if self.skip_linking {
            cmd.arg("-c");
        }

        cmd.arg(assembly.as_ref())
            .arg("-o")
            .arg(self.output.clone().unwrap_or_else(|| {
                self.input
                    .with_extension(if self.skip_linking { "o" } else { "" })
            }));

        let status = cmd.spawn().into_diagnostic()?.wait().into_diagnostic()?;

        if status.success() {
            Ok(())
        } else {
            bail!("{cmd:?}")
        }
    }

    fn write_test_output<F, S: AsRef<str>>(&self, file: impl AsRef<Utf8Path>, contents: F)
    where
        F: FnOnce() -> S,
    {
        let Some(test_output_dir) = self.test_output_dir.as_ref() else {
            return;
        };

        let mut output_file = test_output_dir.clone();
        output_file.extend(
            self.input
                .components()
                .skip_while(|comp| comp.as_os_str() != "tests"),
        );
        output_file.push(file);
        create_dir_all(output_file.parent().unwrap()).unwrap();
        fs_err::write(output_file, contents().as_ref()).unwrap();
    }
}

impl Drop for Driver {
    fn drop(&mut self) {
        if !self.keep_artifacts {
            for artifact in self.artifacts.drain(..) {
                let _ = fs_err::remove_file(artifact);
            }
        }
    }
}

fn main() -> Result<()> {
    let mut driver = Driver::parse();

    match driver.run() {
        Ok(_) => Ok(()),
        Err(err) => {
            driver.write_test_output("error.txt", || format!("{err:?}"));
            Err(err)
        }
    }
}
