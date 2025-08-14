	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.cond:
	cmpl $10, -16(%rbp)
	movl $0, -20(%rbp)
	setL -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
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
	jmp Lloop.0.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
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
