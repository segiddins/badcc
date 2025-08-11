	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $28, %rsp
	movl $100, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.start:
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $-1, -4(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.0
	movl -8(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $1, -8(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	cmpl $100, -8(%rbp)
	movl $0, -20(%rbp)
	setNE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $100, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.1.start:
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $-1, -4(%rbp)
	cmpl $0, -4(%rbp)
	jE Lloop.1
	movl -8(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $1, -8(%rbp)
	jmp Lloop.1.start
	Lloop.1:
	cmpl $99, -8(%rbp)
	movl $0, -28(%rbp)
	setNE -28(%rbp)
	cmpl $0, -28(%rbp)
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
