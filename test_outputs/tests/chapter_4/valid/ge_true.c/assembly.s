	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, %r11d
	cmpl $1, %r11d
	movl $0, -4(%rbp)
	setGE -4(%rbp)
	movl $4, -8(%rbp)
	negl -8(%rbp)
	movl $1, %r11d
	cmpl -8(%rbp), %r11d
	movl $0, -12(%rbp)
	setGE -12(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	addl %r10d, -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
