	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $2, -12(%rbp)
	movl $4, -16(%rbp)
	negl -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl $7, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	cmpl $8, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.false
	movl $4, -36(%rbp)
	negl -36(%rbp)
	movl -36(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
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
