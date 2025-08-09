	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $5, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.start:
	cmpl $0, -12(%rbp)
	movl $0, -20(%rbp)
	setGE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	Lloop.1.start:
	cmpl $10, -24(%rbp)
	movl $0, -28(%rbp)
	setLE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lloop.1
	movl -24(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -24(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.0.true
	jmp Lloop.1.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -16(%rbp), %r10d
	movl %r10d, -40(%rbp)
	addl $1, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.1.start
	Lloop.1:
	movl -12(%rbp), %r10d
	movl %r10d, -44(%rbp)
	subl $1, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
