	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $2147483647, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.0.cond:
	movl -16(%rbp), %eax
	cdq
	movl $5, %r10d
	idivl %r10d
	movl %edx, -20(%rbp)
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lloop.0
	movl -16(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.0.start:
	jmp Lloop.0.cond
	Lloop.0:
	movl -16(%rbp), %eax
	cdq
	movl $5, %r10d
	idivl %r10d
	movl %edx, -32(%rbp)
	cmpl $0, -32(%rbp)
	jNE Lmain.0.true
	cmpl $0, -16(%rbp)
	movl $0, -36(%rbp)
	setG -36(%rbp)
	cmpl $0, -36(%rbp)
	jNE Lmain.0.true
	movl $0, -40(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $1, -40(%rbp)
	Lmain.0.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
