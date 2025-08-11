	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $7, %r11d
	cmpl $5, %r11d
	movl $0, -4(%rbp)
	setL -4(%rbp)
	movl $5, -8(%rbp)
	movl -4(%rbp), %r10d
	xorl %r10d, -8(%rbp)
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
