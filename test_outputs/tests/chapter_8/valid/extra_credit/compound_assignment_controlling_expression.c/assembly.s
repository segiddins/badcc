	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $100, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.head:
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $2, -8(%rbp)
	Lloop.0.start:
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	subl $1, -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	cmpl $0, -4(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.false
	cmpl $200, -8(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.false
	movl $1, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -12(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
