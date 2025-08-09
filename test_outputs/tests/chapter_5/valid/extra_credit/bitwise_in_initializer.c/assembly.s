	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $15, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	xorl $5, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl $1, -24(%rbp)
	movl -20(%rbp), %r10d
	orl %r10d, -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
