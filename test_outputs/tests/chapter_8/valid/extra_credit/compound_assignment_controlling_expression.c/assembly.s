	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $100, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.head:
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $2, -16(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	subl $1, -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	cmpl $0, -12(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.false
	cmpl $200, -16(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.false
	movl $1, -28(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -28(%rbp)
	Lmain.0.end:
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
