	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $0, -4(%rbp)
	jmp Ltarget
	movl $5, -4(%rbp)
	Lloop.0.cond:
	cmpl $10, -4(%rbp)
	movl $0, -8(%rbp)
	setL -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lloop.0
	Ltarget:
	cmpl $0, -4(%rbp)
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.0.start:
	movl -4(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
