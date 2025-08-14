	.bss
_counter.2:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.cond:
	cmpl $10, -16(%rbp)
	movl $0, -20(%rbp)
	setLE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	movl -16(%rbp), %r10d
	movl %r10d, _counter.2(%rip)
	movl -16(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -24(%rbp)
	cmpl $0, -24(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.true
	jmp Lloop.0.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	movl -16(%rbp), %r10d
	movl %r10d, -36(%rbp)
	addl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $5, -12(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.1.false
	cmpl $10, _counter.2(%rip)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.1.false
	movl $1, -48(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -48(%rbp)
	Lmain.1.end:
	movl -48(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
