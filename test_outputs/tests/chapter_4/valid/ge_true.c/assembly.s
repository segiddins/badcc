	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, %r11d
	cmpl $1, %r11d
	movl $0, -12(%rbp)
	setGE -12(%rbp)
	movl $4, -16(%rbp)
	negl -16(%rbp)
	movl $1, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setGE -20(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
