	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $3, -4(%rbp)
	addl $4, -4(%rbp)
	movl $2, -8(%rbp)
	movl -8(%rbp), %r11d
	imull -4(%rbp), %r11d
	movl %r11d, -8(%rbp)
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
