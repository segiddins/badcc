	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $36, %rsp
	movl $0, -4(%rbp)
	movl $100, -8(%rbp)
	Lloop.0.start:
	cmpl $0, -8(%rbp)
	jE Lloop.0
	movl $10, -12(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	subl %r10d, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -8(%rbp)
	Lloop.1.start:
	cmpl $0, -12(%rbp)
	jE Lloop.1
	movl -4(%rbp), %r10d
	movl %r10d, -20(%rbp)
	addl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	subl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.1.start
	Lloop.1:
	jmp Lloop.0.start
	Lloop.0:
	cmpl $100, -4(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.false
	cmpl $0, -8(%rbp)
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
