	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $1, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.cond:
	cmpl $10, -8(%rbp)
	movl $0, -12(%rbp)
	setL -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.0
	movl -4(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $2, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lloop.0.start:
	movl -8(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $1, -8(%rbp)
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
