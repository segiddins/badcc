	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl $100, -16(%rbp)
	negl -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	Lloop.0.cond:
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setLE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lloop.0
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	movl -20(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
