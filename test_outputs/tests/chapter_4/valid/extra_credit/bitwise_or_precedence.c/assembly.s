	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $7, %r11d
	cmpl $5, %r11d
	movl $0, -12(%rbp)
	setNE -12(%rbp)
	movl $5, -16(%rbp)
	movl -12(%rbp), %r10d
	orl %r10d, -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
