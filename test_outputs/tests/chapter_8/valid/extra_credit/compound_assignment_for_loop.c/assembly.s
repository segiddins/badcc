	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	movl $1, -16(%rbp)
	negl -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -12(%rbp)
	Lloop.0.cond:
	movl $100, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -24(%rbp)
	setGE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lloop.0
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	subl $3, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl $103, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
