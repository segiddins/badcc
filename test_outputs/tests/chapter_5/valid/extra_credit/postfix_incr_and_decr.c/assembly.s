	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $52, %rsp
	movl $1, -4(%rbp)
	movl $2, -8(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $1, -4(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $-1, -8(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -20(%rbp)
	cmpl $2, -4(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.0.false
	cmpl $1, -8(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.0.false
	movl $1, -36(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -36(%rbp)
	Lmain.0.end:
	cmpl $0, -36(%rbp)
	jE Lmain.1.false
	cmpl $1, -12(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.1.false
	movl $1, -32(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -32(%rbp)
	Lmain.1.end:
	cmpl $0, -32(%rbp)
	jE Lmain.2.false
	cmpl $2, -20(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.2.false
	movl $1, -28(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -28(%rbp)
	Lmain.2.end:
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
