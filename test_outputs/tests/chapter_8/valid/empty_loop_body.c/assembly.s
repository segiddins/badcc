	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $2147483642, -4(%rbp)
	Lloop.0.head:
	Lloop.0.start:
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	subl $5, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -4(%rbp)
	cmpl $256, -4(%rbp)
	movl $0, -12(%rbp)
	setGE -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
