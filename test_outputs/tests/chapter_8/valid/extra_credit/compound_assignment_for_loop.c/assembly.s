	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $1, -4(%rbp)
	movl $1, -8(%rbp)
	negl -8(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -4(%rbp), %r11d
	imull -8(%rbp), %r11d
	movl %r11d, -4(%rbp)
	Lloop.0.cond:
	movl $100, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	cmpl %r10d, -4(%rbp)
	movl $0, -16(%rbp)
	setGE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	Lloop.0.start:
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	subl $3, -4(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl $103, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r10d
	cmpl %r10d, -4(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
