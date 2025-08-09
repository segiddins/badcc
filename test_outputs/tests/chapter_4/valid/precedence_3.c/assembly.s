	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $2, %r11d
	cmpl $0, %r11d
	movl $0, -12(%rbp)
	setGE -12(%rbp)
	movl $2, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
