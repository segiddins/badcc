	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $2, -12(%rbp)
	notl -12(%rbp)
	movl $2, -16(%rbp)
	negl -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -20(%rbp)
	movl $1, -24(%rbp)
	addl $5, -24(%rbp)
	movl -24(%rbp), %r10d
	cmpl %r10d, -20(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
