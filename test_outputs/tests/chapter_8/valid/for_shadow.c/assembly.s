	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $36, %rsp
	movl $1, -4(%rbp)
	movl $0, -8(%rbp)
	movl $0, -12(%rbp)
	Lloop.0.cond:
	cmpl $10, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	movl -8(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -12(%rbp), %r10d
	addl %r10d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -8(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $45, -8(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.false
	cmpl $1, -4(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.0.false
	movl $1, -28(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -28(%rbp)
	Lmain.0.end:
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
