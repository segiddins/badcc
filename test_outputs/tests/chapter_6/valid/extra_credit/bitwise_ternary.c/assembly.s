	.bss
_result.1:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, -12(%rbp)
	xorl $1, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $4, _result.1(%rip)
	movl _result.1(%rip), %r10d
	movl %r10d, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $5, _result.1(%rip)
	movl _result.1(%rip), %r10d
	movl %r10d, -16(%rbp)
	Lmain.0.end:
	movl _result.1(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
