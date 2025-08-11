	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $5, %r11d
	cmpl $0, %r11d
	movl $0, -4(%rbp)
	setGE -4(%rbp)
	cmpl $1, -4(%rbp)
	movl $0, -8(%rbp)
	setG -8(%rbp)
	cmpl $0, -8(%rbp)
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
