	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $1, -4(%rbp)
	negl -4(%rbp)
	movl $1, %r11d
	cmpl -4(%rbp), %r11d
	movl $0, -8(%rbp)
	setLE -8(%rbp)
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
