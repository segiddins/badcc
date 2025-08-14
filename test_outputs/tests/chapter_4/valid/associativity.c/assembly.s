	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $5, %r11d
	cmpl $0, %r11d
	movl $0, -12(%rbp)
	setGE -12(%rbp)
	cmpl $1, -12(%rbp)
	movl $0, -16(%rbp)
	setG -16(%rbp)
	cmpl $0, -16(%rbp)
	movl $0, -20(%rbp)
	setLE -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
