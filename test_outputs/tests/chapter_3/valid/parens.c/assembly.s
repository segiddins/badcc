	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $3, -12(%rbp)
	addl $4, -12(%rbp)
	movl $2, -16(%rbp)
	movl -16(%rbp), %r11d
	imull -12(%rbp), %r11d
	movl %r11d, -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
