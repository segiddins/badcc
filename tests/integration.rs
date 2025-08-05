use std::fs::read_to_string;

use assert_cmd::Command;
use assert_fs::prelude::*;
use insta::assert_snapshot;
use predicates::{path, prelude::*};

fn badcc() -> Command {
    let mut cmd = Command::cargo_bin("badcc").unwrap();
    cmd.arg("--keep-artifacts");
    cmd
}

#[test]
fn test_compiles() {
    let temp = assert_fs::TempDir::new().unwrap();
    let input_file = temp.child("return_2.c");
    input_file
        .write_str("int main(void) { return 2; }")
        .unwrap();

    badcc().arg(input_file.as_os_str()).assert().success();

    // ... do something with input_file ...
    assert_snapshot!(read_to_string(temp.child("return_2.s")).unwrap(), @r"
    	.globl _main
    _main:
    	pushq %rbp
    	movq %rsp, %rbp
    	subq $4, %rsp
    	movl $2, %eax
    	movq %rbp, %rsp
    	popq %rbp
    	ret
    ");

    let exec = temp.child("return_2");
    exec.assert(path::exists());
    Command::new("file")
        .arg(exec.as_os_str())
        .assert()
        .stdout(predicate::str::contains("Mach-O 64-bit executable x86_64"));

    Command::new(temp.child("return_2").as_os_str())
        .assert()
        .code(2);

    temp.close().unwrap();
}
