	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $1, -12(%rbp)
	movl $0, -16(%rbp)
	movl $0, -20(%rbp)
	Lloop.0.cond:
	cmpl $10, -20(%rbp)
	movl $0, -24(%rbp)
	setL -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lloop.0
	movl -16(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.0.start:
	movl -20(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $45, -16(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.0.false
	cmpl $1, -12(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.0.false
	movl $1, -44(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -44(%rbp)
	Lmain.0.end:
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
