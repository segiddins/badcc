	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.cond:
	cmpl $10, -16(%rbp)
	movl $0, -20(%rbp)
	setL -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	movl $0, -24(%rbp)
	Lloop.1.cond:
	cmpl $10, -24(%rbp)
	movl $0, -28(%rbp)
	setL -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lloop.1
	movl -16(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -36(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, -36(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.0.true
	jmp Lloop.1
	jmp Lmain.0.end
	Lmain.0.true:
	movl -12(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lmain.0.end:
	Lloop.1.start:
	movl -24(%rbp), %r10d
	movl %r10d, -48(%rbp)
	addl $1, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -24(%rbp)
	jmp Lloop.1.cond
	Lloop.1:
	Lloop.0.start:
	movl -16(%rbp), %r10d
	movl %r10d, -52(%rbp)
	addl $1, -52(%rbp)
	movl -52(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
