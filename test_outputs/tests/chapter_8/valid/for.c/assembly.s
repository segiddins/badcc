	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $12345, -12(%rbp)
	movl $5, -16(%rbp)
	Lloop.0.cond:
	cmpl $0, -16(%rbp)
	movl $0, -20(%rbp)
	setGE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	movl -12(%rbp), %eax
	cdq
	movl $3, %r10d
	idivl %r10d
	movl %eax, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	movl -16(%rbp), %r10d
	movl %r10d, -28(%rbp)
	subl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
