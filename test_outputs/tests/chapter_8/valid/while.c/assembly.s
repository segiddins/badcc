	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $0, -4(%rbp)
	Lloop.0.start:
	cmpl $5, -4(%rbp)
	movl $0, -8(%rbp)
	setL -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lloop.0
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $2, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
