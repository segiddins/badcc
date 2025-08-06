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

#[test]
fn test_one_plus_one() {
    let temp = assert_fs::TempDir::new().unwrap();
    let input_file = temp.child("return_2.c");
    input_file
        .write_str("int main(void) { return (1+(1)); }")
        .unwrap();

    badcc().arg(input_file.as_os_str()).assert().success();

    // ... do something with input_file ...
    assert_snapshot!(read_to_string(temp.child("return_2.s")).unwrap(), @r"
    	.globl _main
    _main:
    	pushq %rbp
    	movq %rsp, %rbp
    	subq $4, %rsp
    	movl $1, -4(%rbp)
    	addl $1, -4(%rbp)
    	movl -4(%rbp), %eax
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

#[test]
fn test_associativity_3() {
    let temp = assert_fs::TempDir::new().unwrap();
    let input_file = temp.child("return_1.c");
    input_file
        .write_str("int main(void) { return 6 / 3 / 2; }")
        .unwrap();

    badcc().arg(input_file.as_os_str()).assert().success();

    // ... do something with input_file ...
    assert_snapshot!(read_to_string(temp.child("return_1.s")).unwrap(), @r"
    	.globl _main
    _main:
    	pushq %rbp
    	movq %rsp, %rbp
    	subq $8, %rsp
    	movl $6, %eax
    	cdq
    	movl $3, %r10d
    	idivl %r10d
    	movl %eax, -4(%rbp)
    	movl -4(%rbp), %eax
    	cdq
    	movl $2, %r10d
    	idivl %r10d
    	movl %eax, -8(%rbp)
    	movl -8(%rbp), %eax
    	movq %rbp, %rsp
    	popq %rbp
    	ret
    ");

    Command::new(temp.child("return_1").as_os_str())
        .assert()
        .code(1);

    temp.close().unwrap();
}

#[test]
fn test_unop_add() {
    let temp = assert_fs::TempDir::new().unwrap();
    let input_file = temp.child("return_0.c");
    input_file
        .write_str("int main(void) { return ~2 + 3; }")
        .unwrap();

    badcc().arg(input_file.as_os_str()).assert().success();

    // ... do something with input_file ...
    assert_snapshot!(read_to_string(temp.child("return_0.s")).unwrap(), @r"
    	.globl _main
    _main:
    	pushq %rbp
    	movq %rsp, %rbp
    	subq $8, %rsp
    	movl $2, -4(%rbp)
    	notl -4(%rbp)
    	movl -4(%rbp), %r10d
    	movl %r10d, -8(%rbp)
    	addl $3, -8(%rbp)
    	movl -8(%rbp), %eax
    	movq %rbp, %rsp
    	popq %rbp
    	ret
    ");

    Command::new(temp.child("return_0").as_os_str())
        .assert()
        .code(0);

    temp.close().unwrap();
}

#[test]
fn test_shifts() {
    let temp = assert_fs::TempDir::new().unwrap();
    let input_file = temp.child("return_1.c");
    input_file
        .write_str("int main(void) { return (1 << 2) >> 1 >> (1+0); }")
        .unwrap();

    badcc().arg(input_file.as_os_str()).assert().success();

    // ... do something with input_file ...
    assert_snapshot!(read_to_string(temp.child("return_1.s")).unwrap(), @r"
    	.globl _main
    _main:
    	pushq %rbp
    	movq %rsp, %rbp
    	subq $16, %rsp
    	movl $1, -4(%rbp)
    	movl -4(%rbp), %r11d
    	sall $2, %r11d
    	movl %r11d, -4(%rbp)
    	movl -4(%rbp), %r10d
    	movl %r10d, -8(%rbp)
    	movl -8(%rbp), %r11d
    	sarl $1, %r11d
    	movl %r11d, -8(%rbp)
    	movl $1, -12(%rbp)
    	addl $0, -12(%rbp)
    	movl -8(%rbp), %r10d
    	movl %r10d, -16(%rbp)
    	movl -16(%rbp), %r11d
    	movl -12(%rbp), %ecx
    	sarl %cl, %r11d
    	movl %r11d, -16(%rbp)
    	movl -16(%rbp), %eax
    	movq %rbp, %rsp
    	popq %rbp
    	ret
    ");

    Command::new(temp.child("return_1").as_os_str())
        .assert()
        .code(1);

    temp.close().unwrap();
}
