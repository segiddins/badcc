	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $12345, -4(%rbp)
	movl $5, -8(%rbp)
	Lloop.0.cond:
	cmpl $0, -8(%rbp)
	movl $0, -12(%rbp)
	setGE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.0
	movl -4(%rbp), %eax
	cdq
	movl $3, %r10d
	idivl %r10d
	movl %eax, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lloop.0.start:
	movl -8(%rbp), %r10d
	movl %r10d, -20(%rbp)
	subl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
