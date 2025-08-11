	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $36, %rsp
	movl $5, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.start:
	cmpl $0, -4(%rbp)
	movl $0, -12(%rbp)
	setGE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.0
	movl -4(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.1.start:
	cmpl $10, -16(%rbp)
	movl $0, -20(%rbp)
	setLE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.1
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.true
	jmp Lloop.1.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -8(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lloop.1.start
	Lloop.1:
	movl -4(%rbp), %r10d
	movl %r10d, -36(%rbp)
	subl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
