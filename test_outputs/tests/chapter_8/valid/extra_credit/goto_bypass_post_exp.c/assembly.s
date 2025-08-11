	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.cond:
	Llbl:
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -8(%rbp)
	cmpl $10, -8(%rbp)
	movl $0, -20(%rbp)
	setG -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	jmp Lloop.0
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	jmp Llbl
	Lloop.0.start:
	movl $0, -8(%rbp)
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
