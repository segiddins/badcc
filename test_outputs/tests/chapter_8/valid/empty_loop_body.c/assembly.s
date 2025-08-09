	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $2147483642, -12(%rbp)
	Lloop.0.head:
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	subl $5, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $256, -12(%rbp)
	movl $0, -20(%rbp)
	setGE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
