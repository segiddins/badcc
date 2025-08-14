	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $20, -12(%rbp)
	movl -12(%rbp), %r11d
	sarl $4, %r11d
	movl %r11d, -12(%rbp)
	movl $3, -16(%rbp)
	movl -16(%rbp), %r11d
	sall $1, %r11d
	movl %r11d, -16(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
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
