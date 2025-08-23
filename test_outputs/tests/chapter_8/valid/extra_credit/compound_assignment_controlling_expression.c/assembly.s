	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $100, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.head:
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	addl $2, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	subl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	cmpl $0, -12(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.false
	cmpl $200, -16(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.false
	movl $1, -36(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -36(%rbp)
	Lmain.0.end:
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
