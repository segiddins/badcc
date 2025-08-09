	.globl _f
_f:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movl %ecx, -24(%rbp)
	movl -12(%rbp), %eax
	cdq
	idivl -16(%rbp)
	movl %eax, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	cmpl $10, -12(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lf.1.false
	cmpl $2, -16(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lf.1.false
	movl $1, -44(%rbp)
	jmp Lf.1.end
	Lf.1.false:
	movl $0, -44(%rbp)
	Lf.1.end:
	cmpl $0, -44(%rbp)
	jE Lf.2.false
	cmpl $100, -20(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lf.2.false
	movl $1, -52(%rbp)
	jmp Lf.2.end
	Lf.2.false:
	movl $0, -52(%rbp)
	Lf.2.end:
	cmpl $0, -52(%rbp)
	jE Lf.3.false
	cmpl $4, -24(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lf.3.false
	movl $1, -60(%rbp)
	jmp Lf.3.end
	Lf.3.false:
	movl $0, -60(%rbp)
	Lf.3.end:
	cmpl $0, -60(%rbp)
	jE Lf.4.false
	cmpl $5, -32(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lf.4.false
	movl $1, -68(%rbp)
	jmp Lf.4.end
	Lf.4.false:
	movl $0, -68(%rbp)
	Lf.4.end:
	cmpl $0, -68(%rbp)
	jE Lf.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.0.end
	Lf.0.true:
	Lf.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
