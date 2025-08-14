	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $1, -12(%rbp)
	movl $2, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $-1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	cmpl $2, -12(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.false
	cmpl $1, -16(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.false
	movl $1, -36(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -36(%rbp)
	Lmain.0.end:
	cmpl $0, -36(%rbp)
	jE Lmain.1.false
	cmpl $2, -20(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.1.false
	movl $1, -44(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -44(%rbp)
	Lmain.1.end:
	cmpl $0, -44(%rbp)
	jE Lmain.2.false
	cmpl $1, -24(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.2.false
	movl $1, -52(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -52(%rbp)
	Lmain.2.end:
	movl -52(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
