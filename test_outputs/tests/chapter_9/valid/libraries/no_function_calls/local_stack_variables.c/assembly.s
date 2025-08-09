	.globl _f
_f:
	pushq %rbp
	movq %rsp, %rbp
	subq $144, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movl %ecx, -24(%rbp)
	movl %r8d, -28(%rbp)
	movl %r9d, -32(%rbp)
	movl 16(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl 24(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl 32(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl $10, -48(%rbp)
	cmpl $1, -12(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lf.1.false
	cmpl $2, -16(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lf.1.false
	movl $1, -60(%rbp)
	jmp Lf.1.end
	Lf.1.false:
	movl $0, -60(%rbp)
	Lf.1.end:
	cmpl $0, -60(%rbp)
	jE Lf.2.false
	cmpl $3, -20(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lf.2.false
	movl $1, -68(%rbp)
	jmp Lf.2.end
	Lf.2.false:
	movl $0, -68(%rbp)
	Lf.2.end:
	cmpl $0, -68(%rbp)
	jE Lf.3.false
	cmpl $4, -24(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lf.3.false
	movl $1, -76(%rbp)
	jmp Lf.3.end
	Lf.3.false:
	movl $0, -76(%rbp)
	Lf.3.end:
	cmpl $0, -76(%rbp)
	jE Lf.4.false
	cmpl $5, -28(%rbp)
	movl $0, -80(%rbp)
	setE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lf.4.false
	movl $1, -84(%rbp)
	jmp Lf.4.end
	Lf.4.false:
	movl $0, -84(%rbp)
	Lf.4.end:
	cmpl $0, -84(%rbp)
	jE Lf.5.false
	cmpl $6, -32(%rbp)
	movl $0, -88(%rbp)
	setE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Lf.5.false
	movl $1, -92(%rbp)
	jmp Lf.5.end
	Lf.5.false:
	movl $0, -92(%rbp)
	Lf.5.end:
	cmpl $0, -92(%rbp)
	jE Lf.6.false
	movl $1, -96(%rbp)
	negl -96(%rbp)
	movl -96(%rbp), %r10d
	cmpl %r10d, -36(%rbp)
	movl $0, -100(%rbp)
	setE -100(%rbp)
	cmpl $0, -100(%rbp)
	jE Lf.6.false
	movl $1, -104(%rbp)
	jmp Lf.6.end
	Lf.6.false:
	movl $0, -104(%rbp)
	Lf.6.end:
	cmpl $0, -104(%rbp)
	jE Lf.7.false
	movl $2, -108(%rbp)
	negl -108(%rbp)
	movl -108(%rbp), %r10d
	cmpl %r10d, -40(%rbp)
	movl $0, -112(%rbp)
	setE -112(%rbp)
	cmpl $0, -112(%rbp)
	jE Lf.7.false
	movl $1, -116(%rbp)
	jmp Lf.7.end
	Lf.7.false:
	movl $0, -116(%rbp)
	Lf.7.end:
	cmpl $0, -116(%rbp)
	jE Lf.8.false
	movl $3, -120(%rbp)
	negl -120(%rbp)
	movl -120(%rbp), %r10d
	cmpl %r10d, -44(%rbp)
	movl $0, -124(%rbp)
	setE -124(%rbp)
	cmpl $0, -124(%rbp)
	jE Lf.8.false
	movl $1, -128(%rbp)
	jmp Lf.8.end
	Lf.8.false:
	movl $0, -128(%rbp)
	Lf.8.end:
	cmpl $0, -128(%rbp)
	jE Lf.9.false
	cmpl $10, -48(%rbp)
	movl $0, -132(%rbp)
	setE -132(%rbp)
	cmpl $0, -132(%rbp)
	jE Lf.9.false
	movl $1, -136(%rbp)
	jmp Lf.9.end
	Lf.9.false:
	movl $0, -136(%rbp)
	Lf.9.end:
	cmpl $0, -136(%rbp)
	jE Lf.0.true
	movl $100, -40(%rbp)
	movl -40(%rbp), %eax
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
