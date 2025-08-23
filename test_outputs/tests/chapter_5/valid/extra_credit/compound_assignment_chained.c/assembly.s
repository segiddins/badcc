	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $144, %rsp
	movl $250, -12(%rbp)
	movl $200, -16(%rbp)
	movl $100, -20(%rbp)
	movl $75, -24(%rbp)
	movl $25, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl $0, -36(%rbp)
	movl $0, -40(%rbp)
	movl $7, -44(%rbp)
	negl -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -32(%rbp), %eax
	cdq
	idivl -36(%rbp)
	movl %edx, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -24(%rbp), %eax
	cdq
	idivl -32(%rbp)
	movl %eax, -52(%rbp)
	movl -52(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -56(%rbp)
	movl -56(%rbp), %r11d
	imull -24(%rbp), %r11d
	movl %r11d, -56(%rbp)
	movl -56(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -60(%rbp)
	movl -20(%rbp), %r10d
	subl %r10d, -60(%rbp)
	movl -60(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -40(%rbp)
	cmpl $2250, -12(%rbp)
	movl $0, -68(%rbp)
	setE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.0.false
	cmpl $2000, -16(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.0.false
	movl $1, -76(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -76(%rbp)
	Lmain.0.end:
	cmpl $0, -76(%rbp)
	jE Lmain.1.false
	movl $1800, -80(%rbp)
	negl -80(%rbp)
	movl -80(%rbp), %r10d
	cmpl %r10d, -20(%rbp)
	movl $0, -84(%rbp)
	setE -84(%rbp)
	cmpl $0, -84(%rbp)
	jE Lmain.1.false
	movl $1, -88(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -88(%rbp)
	Lmain.1.end:
	cmpl $0, -88(%rbp)
	jE Lmain.2.false
	movl $18, -92(%rbp)
	negl -92(%rbp)
	movl -92(%rbp), %r10d
	cmpl %r10d, -24(%rbp)
	movl $0, -96(%rbp)
	setE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lmain.2.false
	movl $1, -100(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -100(%rbp)
	Lmain.2.end:
	cmpl $0, -100(%rbp)
	jE Lmain.3.false
	movl $4, -104(%rbp)
	negl -104(%rbp)
	movl -104(%rbp), %r10d
	cmpl %r10d, -32(%rbp)
	movl $0, -108(%rbp)
	setE -108(%rbp)
	cmpl $0, -108(%rbp)
	jE Lmain.3.false
	movl $1, -112(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -112(%rbp)
	Lmain.3.end:
	cmpl $0, -112(%rbp)
	jE Lmain.4.false
	movl $7, -116(%rbp)
	negl -116(%rbp)
	movl -116(%rbp), %r10d
	cmpl %r10d, -36(%rbp)
	movl $0, -120(%rbp)
	setE -120(%rbp)
	cmpl $0, -120(%rbp)
	jE Lmain.4.false
	movl $1, -124(%rbp)
	jmp Lmain.4.end
	Lmain.4.false:
	movl $0, -124(%rbp)
	Lmain.4.end:
	cmpl $0, -124(%rbp)
	jE Lmain.5.false
	cmpl $2250, -40(%rbp)
	movl $0, -128(%rbp)
	setE -128(%rbp)
	cmpl $0, -128(%rbp)
	jE Lmain.5.false
	movl $1, -132(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -132(%rbp)
	Lmain.5.end:
	movl -132(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
