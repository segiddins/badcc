	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $44, %rsp
	movl $10, -4(%rbp)
	movl $20, -8(%rbp)
	movl $20, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -8(%rbp)
	Lloop.0.cond:
	cmpl $0, -8(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	movl -4(%rbp), %r10d
	movl %r10d, -20(%rbp)
	subl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -4(%rbp)
	cmpl $0, -4(%rbp)
	movl $0, -24(%rbp)
	setLE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.true
	jmp Lloop.0
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.0.start:
	movl -8(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $0, -4(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.1.false
	movl $11, -40(%rbp)
	negl -40(%rbp)
	movl -40(%rbp), %r10d
	cmpl %r10d, -8(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.1.false
	movl $1, -32(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -32(%rbp)
	Lmain.1.end:
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
