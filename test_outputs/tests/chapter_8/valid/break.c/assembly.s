	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $10, -12(%rbp)
	movl $20, -16(%rbp)
	movl $20, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.0.cond:
	cmpl $0, -16(%rbp)
	movl $0, -24(%rbp)
	setL -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lloop.0
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	subl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -32(%rbp)
	setLE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.true
	jmp Lloop.0
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.0.start:
	movl -16(%rbp), %r10d
	movl %r10d, -36(%rbp)
	addl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $0, -12(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.1.false
	movl $11, -44(%rbp)
	negl -44(%rbp)
	movl -44(%rbp), %r10d
	cmpl %r10d, -16(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.1.false
	movl $1, -52(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -52(%rbp)
	Lmain.1.end:
	movl -52(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
