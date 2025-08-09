	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl $1, -12(%rbp)
	movl $2, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $-1, -16(%rbp)
	cmpl $0, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	cmpl $2, -12(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.0.false
	cmpl $1, -16(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.0.false
	movl $1, -48(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -48(%rbp)
	Lmain.0.end:
	cmpl $0, -48(%rbp)
	jE Lmain.1.false
	movl $2, -52(%rbp)
	negl -52(%rbp)
	movl -52(%rbp), %r10d
	cmpl %r10d, -24(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.1.false
	movl $1, -60(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -60(%rbp)
	Lmain.1.end:
	cmpl $0, -60(%rbp)
	jE Lmain.2.false
	cmpl $0, -36(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.2.false
	movl $1, -68(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -68(%rbp)
	Lmain.2.end:
	movl -68(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
