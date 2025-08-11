	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $80, -4(%rbp)
	movl -4(%rbp), %r11d
	sarl $2, %r11d
	movl %r11d, -4(%rbp)
	movl $7, -8(%rbp)
	movl -8(%rbp), %r11d
	sall $1, %r11d
	movl %r11d, -8(%rbp)
	movl $5, -12(%rbp)
	movl -8(%rbp), %r10d
	andl %r10d, -12(%rbp)
	movl $1, -16(%rbp)
	movl -12(%rbp), %r10d
	xorl %r10d, -16(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	orl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
