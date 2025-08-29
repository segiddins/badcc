	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	movq %r11, -24(%rbp)
	movq $10, -32(%rbp)
	negq -32(%rbp)
	movq -24(%rbp), %rax
	cqo
	idivq -32(%rbp)
	movq %rax, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl $3865470567, %r10d
	cmpl %r10d, -16(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movl -52(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
