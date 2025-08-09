	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	Lloop.0.head:
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	cmpl $11, -12(%rbp)
	movl $0, -20(%rbp)
	setL -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
