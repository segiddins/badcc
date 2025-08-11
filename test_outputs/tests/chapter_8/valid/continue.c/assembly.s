	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $44, %rsp
	movl $0, -4(%rbp)
	movl $0, -12(%rbp)
	Lloop.0.cond:
	cmpl $10, -12(%rbp)
	movl $0, -16(%rbp)
	setLE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	movl -12(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -12(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -20(%rbp)
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.true
	jmp Lloop.0.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -4(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $5, -4(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.1.false
	cmpl $10, -8(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.1.false
	movl $1, -36(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -36(%rbp)
	Lmain.1.end:
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
