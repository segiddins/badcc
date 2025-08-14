	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	Lloop.0.start:
	cmpl $5, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	addl $2, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
