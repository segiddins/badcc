	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $2147483647, -8(%rbp)
	negl -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lloop.0.cond:
	movl -4(%rbp), %eax
	cdq
	movl $5, %r10d
	idivl %r10d
	movl %edx, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	movl -4(%rbp), %r10d
	movl %r10d, -20(%rbp)
	addl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lloop.0.start:
	jmp Lloop.0.cond
	Lloop.0:
	movl -4(%rbp), %eax
	cdq
	movl $5, %r10d
	idivl %r10d
	movl %edx, -28(%rbp)
	cmpl $0, -28(%rbp)
	jNE Lmain.0.true
	cmpl $0, -4(%rbp)
	movl $0, -32(%rbp)
	setG -32(%rbp)
	cmpl $0, -32(%rbp)
	jNE Lmain.0.true
	movl $0, -24(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $1, -24(%rbp)
	Lmain.0.end:
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
