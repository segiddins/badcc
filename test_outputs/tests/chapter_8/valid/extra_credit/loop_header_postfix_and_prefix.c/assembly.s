	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $100, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $-1, -12(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	cmpl $100, -16(%rbp)
	movl $0, -28(%rbp)
	setNE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $100, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.1.start:
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $-1, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.1
	movl -16(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	jmp Lloop.1.start
	Lloop.1:
	cmpl $99, -16(%rbp)
	movl $0, -36(%rbp)
	setNE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.1.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
