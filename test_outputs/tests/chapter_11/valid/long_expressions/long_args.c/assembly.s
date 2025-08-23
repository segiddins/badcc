	.globl _test_sum
	.text
_test_sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
	movl %edx, -28(%rbp)
	movl %ecx, -32(%rbp)
	movl %r8d, -36(%rbp)
	movl %r9d, -40(%rbp)
	movl 16(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl 24(%rbp), %r10d
	movl %r10d, -48(%rbp)
	movq 32(%rbp), %r10
	movq %r10, -56(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -64(%rbp)
	movq -24(%rbp), %r10
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
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	subq $8, %rsp
	movq $34359738368, %rdi
	movq $34359738368, %rsi
	movl $0, %edx
	movl $0, %ecx
	movl $0, %r8d
	movl $0, %r9d
	movq $34359738368, %rax
	pushq %rax
	pushq $0
	pushq $0
	call _test_sum
	addq $32, %rsp
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
