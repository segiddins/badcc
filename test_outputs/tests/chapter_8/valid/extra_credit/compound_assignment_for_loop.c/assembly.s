	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $1, -12(%rbp)
	movl $1, -16(%rbp)
	negl -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.cond:
	movl $100, -24(%rbp)
	negl -24(%rbp)
	movl -24(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -28(%rbp)
	setGE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lloop.0
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	subl $3, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl $103, -36(%rbp)
	negl -36(%rbp)
	movl -36(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
