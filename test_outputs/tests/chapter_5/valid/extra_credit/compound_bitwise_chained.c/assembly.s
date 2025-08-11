	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $116, %rsp
	movl $250, -4(%rbp)
	movl $200, -8(%rbp)
	movl $100, -12(%rbp)
	movl $75, -16(%rbp)
	movl $50, -20(%rbp)
	movl $25, -24(%rbp)
	movl $10, -28(%rbp)
	movl $1, -32(%rbp)
	movl $0, -36(%rbp)
	movl $0, -40(%rbp)
	movl $1, -36(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -32(%rbp), %r11d
	movl -36(%rbp), %ecx
	sall %cl, %r11d
	movl %r11d, -32(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r11d
	movl -32(%rbp), %ecx
	sarl %cl, %r11d
	movl %r11d, -28(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -28(%rbp), %r10d
	addl %r10d, -24(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -24(%rbp), %r10d
	xorl %r10d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -16(%rbp), %r10d
	orl %r10d, -12(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -8(%rbp), %r11d
	imull -12(%rbp), %r11d
	movl %r11d, -8(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -8(%rbp), %r10d
	andl %r10d, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -40(%rbp)
	cmpl $40, -4(%rbp)
	movl $0, -80(%rbp)
	setE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lmain.0.false
	cmpl $21800, -8(%rbp)
	movl $0, -84(%rbp)
	setE -84(%rbp)
	cmpl $0, -84(%rbp)
	jE Lmain.0.false
	movl $1, -76(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -76(%rbp)
	Lmain.0.end:
	cmpl $0, -76(%rbp)
	jE Lmain.1.false
	cmpl $109, -12(%rbp)
	movl $0, -88(%rbp)
	setE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Lmain.1.false
	movl $1, -72(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -72(%rbp)
	Lmain.1.end:
	cmpl $0, -72(%rbp)
	jE Lmain.2.false
	cmpl $41, -16(%rbp)
	movl $0, -92(%rbp)
	setE -92(%rbp)
	cmpl $0, -92(%rbp)
	jE Lmain.2.false
	movl $1, -68(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -68(%rbp)
	Lmain.2.end:
	cmpl $0, -68(%rbp)
	jE Lmain.3.false
	cmpl $41, -20(%rbp)
	movl $0, -96(%rbp)
	setE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lmain.3.false
	movl $1, -64(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -64(%rbp)
	Lmain.3.end:
	cmpl $0, -64(%rbp)
	jE Lmain.4.false
	cmpl $27, -24(%rbp)
	movl $0, -100(%rbp)
	setE -100(%rbp)
	cmpl $0, -100(%rbp)
	jE Lmain.4.false
	movl $1, -60(%rbp)
	jmp Lmain.4.end
	Lmain.4.false:
	movl $0, -60(%rbp)
	Lmain.4.end:
	cmpl $0, -60(%rbp)
	jE Lmain.5.false
	cmpl $2, -28(%rbp)
	movl $0, -104(%rbp)
	setE -104(%rbp)
	cmpl $0, -104(%rbp)
	jE Lmain.5.false
	movl $1, -56(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -56(%rbp)
	Lmain.5.end:
	cmpl $0, -56(%rbp)
	jE Lmain.6.false
	cmpl $2, -32(%rbp)
	movl $0, -108(%rbp)
	setE -108(%rbp)
	cmpl $0, -108(%rbp)
	jE Lmain.6.false
	movl $1, -52(%rbp)
	jmp Lmain.6.end
	Lmain.6.false:
	movl $0, -52(%rbp)
	Lmain.6.end:
	cmpl $0, -52(%rbp)
	jE Lmain.7.false
	cmpl $1, -36(%rbp)
	movl $0, -112(%rbp)
	setE -112(%rbp)
	cmpl $0, -112(%rbp)
	jE Lmain.7.false
	movl $1, -48(%rbp)
	jmp Lmain.7.end
	Lmain.7.false:
	movl $0, -48(%rbp)
	Lmain.7.end:
	cmpl $0, -48(%rbp)
	jE Lmain.8.false
	cmpl $40, -40(%rbp)
	movl $0, -116(%rbp)
	setE -116(%rbp)
	cmpl $0, -116(%rbp)
	jE Lmain.8.false
	movl $1, -44(%rbp)
	jmp Lmain.8.end
	Lmain.8.false:
	movl $0, -44(%rbp)
	Lmain.8.end:
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
