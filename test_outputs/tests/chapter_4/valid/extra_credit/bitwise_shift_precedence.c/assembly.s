	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $20, -4(%rbp)
	movl -4(%rbp), %r11d
	sarl $4, %r11d
	movl %r11d, -4(%rbp)
	movl $3, -8(%rbp)
	movl -8(%rbp), %r11d
	sall $1, %r11d
	movl %r11d, -8(%rbp)
	movl -8(%rbp), %r10d
	cmpl %r10d, -4(%rbp)
	movl $0, -12(%rbp)
	setLE -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
