	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	movl $10, -4(%rbp)
	movl $0, -8(%rbp)
	movl $0, -12(%rbp)
	Lloop.0.head:
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $0, -4(%rbp)
	movl $0, -20(%rbp)
	setLE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	jmp Lloop.0.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -4(%rbp), %r10d
	movl %r10d, -24(%rbp)
	subl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -4(%rbp)
	cmpl $10, -8(%rbp)
	movl $0, -28(%rbp)
	setGE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.1.true
	jmp Lloop.0.start
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl -8(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -8(%rbp)
	Lloop.0.start:
	cmpl $50, -12(%rbp)
	movl $0, -36(%rbp)
	setNE -36(%rbp)
	cmpl $0, -36(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	cmpl $50, -12(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.2.false
	cmpl $0, -4(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.2.false
	movl $1, -44(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -44(%rbp)
	Lmain.2.end:
	cmpl $0, -44(%rbp)
	jE Lmain.3.false
	cmpl $10, -8(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.3.false
	movl $1, -40(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -40(%rbp)
	Lmain.3.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
