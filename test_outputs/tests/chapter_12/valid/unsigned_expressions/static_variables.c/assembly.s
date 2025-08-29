	.data
_x:
	.quad 9223372036854775803
	.globl _zero_int
	.bss
_zero_int:
	.zero 4

	.globl _zero_long
	.bss
_zero_long:
	.zero 8

	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq $9223372036854775803, %r10
	cmpq %r10, _x(%rip)
	movq $0, -16(%rbp)
	setNE -16(%rbp)
	cmpq $0, -16(%rbp)
	jE Lmain.0.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq _x(%rip), %r10
	movq %r10, -24(%rbp)
	addq $10, -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, _x(%rip)
	movq $-9223372036854775803, %r10
	cmpq %r10, _x(%rip)
	movq $0, -32(%rbp)
	setNE -32(%rbp)
	cmpq $0, -32(%rbp)
	jE Lmain.1.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	cmpq $0, _zero_long(%rip)
	jNE Lmain.3.true
	movl _zero_int(%rip), %r11d
	movq %r11, -40(%rbp)
	cmpq $0, -40(%rbp)
	jNE Lmain.3.true
	movl $0, -44(%rbp)
	jmp Lmain.3.end
	Lmain.3.true:
	movl $1, -44(%rbp)
	Lmain.3.end:
	cmpl $0, -44(%rbp)
	jE Lmain.2.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
