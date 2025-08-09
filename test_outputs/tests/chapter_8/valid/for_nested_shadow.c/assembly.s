	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	movl $1, -20(%rbp)
	movl $100, -24(%rbp)
	Lloop.0.cond:
	cmpl $0, -24(%rbp)
	movl $0, -28(%rbp)
	setG -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lloop.0
	movl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -20(%rbp)
	Lloop.0.start:
	movl -24(%rbp), %r10d
	movl %r10d, -44(%rbp)
	subl $1, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -24(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $101, -20(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.0.false
	cmpl $0, -12(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.0.false
	movl $1, -56(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -56(%rbp)
	Lmain.0.end:
	cmpl $0, -56(%rbp)
	jE Lmain.1.false
	cmpl $0, -16(%rbp)
	movl $0, -60(%rbp)
	setE -60(%rbp)
	cmpl $0, -60(%rbp)
	jE Lmain.1.false
	movl $1, -64(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -64(%rbp)
	Lmain.1.end:
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
