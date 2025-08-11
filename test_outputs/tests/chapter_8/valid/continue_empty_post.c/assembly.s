	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.cond:
	cmpl $10, -8(%rbp)
	movl $0, -12(%rbp)
	setL -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.0
	movl -8(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -8(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	jmp Lloop.0.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -4(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -8(%rbp), %r10d
	addl %r10d, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lloop.0.start:
	jmp Lloop.0.cond
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
