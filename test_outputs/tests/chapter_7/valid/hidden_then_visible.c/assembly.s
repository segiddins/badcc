	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $36, %rsp
	movl $2, -4(%rbp)
	movl $4, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl $7, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	addl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -8(%rbp)
	cmpl $8, -8(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.false
	movl $4, -32(%rbp)
	negl -32(%rbp)
	movl -32(%rbp), %r10d
	cmpl %r10d, -4(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.0.false
	movl $1, -24(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -24(%rbp)
	Lmain.0.end:
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
