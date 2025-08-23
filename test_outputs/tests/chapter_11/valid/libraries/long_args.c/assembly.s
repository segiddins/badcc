	.globl _test_sum
	.text
_test_sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movq %rcx, -28(%rbp)
	movl %r8d, -32(%rbp)
	movq %r9, -40(%rbp)
	movl 16(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl 24(%rbp), %r10d
	movl %r10d, -48(%rbp)
	movq 32(%rbp), %r10
	movq %r10, -56(%rbp)
	movq -28(%rbp), %r10
	movq %r10, -64(%rbp)
	movq -40(%rbp), %r10
	addq %r10, -64(%rbp)
	cmpq $100, -64(%rbp)
	movq $0, -72(%rbp)
	setL -72(%rbp)
	cmpq $0, -72(%rbp)
	jE Ltest_sum.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Ltest_sum.0.end
	Ltest_sum.0.true:
	Ltest_sum.0.end:
	cmpq $100, -56(%rbp)
	movq $0, -80(%rbp)
	setL -80(%rbp)
	cmpq $0, -80(%rbp)
	jE Ltest_sum.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Ltest_sum.1.end
	Ltest_sum.1.true:
	Ltest_sum.1.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
