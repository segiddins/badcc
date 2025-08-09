	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $-1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $-1, -16(%rbp)
	cmpl $3, -12(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.false
	movl $2, -32(%rbp)
	negl -32(%rbp)
	movl -32(%rbp), %r10d
	cmpl %r10d, -16(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.0.false
	movl $1, -40(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -40(%rbp)
	Lmain.0.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
