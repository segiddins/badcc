	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $10, -12(%rbp)
	movl $0, -16(%rbp)
	movl $0, -20(%rbp)
	Lloop.0.head:
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -20(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -28(%rbp)
	setLE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.true
	jmp Lloop.0.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	subl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $10, -16(%rbp)
	movl $0, -36(%rbp)
	setGE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.1.true
	jmp Lloop.0.start
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl -16(%rbp), %r10d
	movl %r10d, -40(%rbp)
	addl $1, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.0.start:
	cmpl $50, -20(%rbp)
	movl $0, -44(%rbp)
	setNE -44(%rbp)
	cmpl $0, -44(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	cmpl $50, -20(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.2.false
	cmpl $0, -12(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.2.false
	movl $1, -56(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -56(%rbp)
	Lmain.2.end:
	cmpl $0, -56(%rbp)
	jE Lmain.3.false
	cmpl $10, -16(%rbp)
	movl $0, -60(%rbp)
	setE -60(%rbp)
	cmpl $0, -60(%rbp)
	jE Lmain.3.false
	movl $1, -64(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -64(%rbp)
	Lmain.3.end:
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
