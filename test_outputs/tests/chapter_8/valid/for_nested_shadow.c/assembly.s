	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	movl $1, -12(%rbp)
	movl $100, -16(%rbp)
	Lloop.0.cond:
	cmpl $0, -16(%rbp)
	movl $0, -20(%rbp)
	setG -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	movl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -12(%rbp), %r10d
	addl %r10d, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	movl -16(%rbp), %r10d
	movl %r10d, -36(%rbp)
	subl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $101, -12(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.0.false
	cmpl $0, -4(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.0.false
	movl $1, -44(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -44(%rbp)
	Lmain.0.end:
	cmpl $0, -44(%rbp)
	jE Lmain.1.false
	cmpl $0, -8(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.1.false
	movl $1, -40(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -40(%rbp)
	Lmain.1.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
