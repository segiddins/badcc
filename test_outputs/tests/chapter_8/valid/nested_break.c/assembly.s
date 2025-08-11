	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $44, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.cond:
	cmpl $10, -8(%rbp)
	movl $0, -12(%rbp)
	setL -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.0
	movl $0, -16(%rbp)
	Lloop.1.cond:
	cmpl $10, -16(%rbp)
	movl $0, -20(%rbp)
	setL -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.1
	movl -8(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -28(%rbp)
	movl -8(%rbp), %r10d
	cmpl %r10d, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.true
	jmp Lloop.1
	jmp Lmain.0.end
	Lmain.0.true:
	movl -4(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -8(%rbp), %r10d
	addl %r10d, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lmain.0.end:
	Lloop.1.start:
	movl -16(%rbp), %r10d
	movl %r10d, -40(%rbp)
	addl $1, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.1.cond
	Lloop.1:
	Lloop.0.start:
	movl -8(%rbp), %r10d
	movl %r10d, -44(%rbp)
	addl $1, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
