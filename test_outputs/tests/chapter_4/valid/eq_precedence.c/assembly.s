	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $3, %r11d
	cmpl $1, %r11d
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $2, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
