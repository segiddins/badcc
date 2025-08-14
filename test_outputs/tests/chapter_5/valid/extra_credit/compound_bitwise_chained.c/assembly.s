	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $128, %rsp
	movl $250, -12(%rbp)
	movl $200, -16(%rbp)
	movl $100, -20(%rbp)
	movl $75, -24(%rbp)
	movl $50, -28(%rbp)
	movl $25, -32(%rbp)
	movl $10, -36(%rbp)
	movl $1, -40(%rbp)
	movl $0, -44(%rbp)
	movl $0, -48(%rbp)
	movl $1, -44(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %r11d
	movl -44(%rbp), %ecx
	sall %cl, %r11d
	movl %r11d, -40(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r11d
	movl -40(%rbp), %ecx
	sarl %cl, %r11d
	movl %r11d, -36(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -36(%rbp), %r10d
	addl %r10d, -32(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -32(%rbp), %r10d
	xorl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -24(%rbp), %r10d
	orl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	imull -20(%rbp), %r11d
	movl %r11d, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -16(%rbp), %r10d
	andl %r10d, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -48(%rbp)
	cmpl $40, -12(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.0.false
	cmpl $21800, -16(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.0.false
	movl $1, -60(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -60(%rbp)
	Lmain.0.end:
	cmpl $0, -60(%rbp)
	jE Lmain.1.false
	cmpl $109, -20(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.1.false
	movl $1, -68(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -68(%rbp)
	Lmain.1.end:
	cmpl $0, -68(%rbp)
	jE Lmain.2.false
	cmpl $41, -24(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.2.false
	movl $1, -76(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -76(%rbp)
	Lmain.2.end:
	cmpl $0, -76(%rbp)
	jE Lmain.3.false
	cmpl $41, -28(%rbp)
	movl $0, -80(%rbp)
	setE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lmain.3.false
	movl $1, -84(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -84(%rbp)
	Lmain.3.end:
	cmpl $0, -84(%rbp)
	jE Lmain.4.false
	cmpl $27, -32(%rbp)
	movl $0, -88(%rbp)
	setE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Lmain.4.false
	movl $1, -92(%rbp)
	jmp Lmain.4.end
	Lmain.4.false:
	movl $0, -92(%rbp)
	Lmain.4.end:
	cmpl $0, -92(%rbp)
	jE Lmain.5.false
	cmpl $2, -36(%rbp)
	movl $0, -96(%rbp)
	setE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lmain.5.false
	movl $1, -100(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -100(%rbp)
	Lmain.5.end:
	cmpl $0, -100(%rbp)
	jE Lmain.6.false
	cmpl $2, -40(%rbp)
	movl $0, -104(%rbp)
	setE -104(%rbp)
	cmpl $0, -104(%rbp)
	jE Lmain.6.false
	movl $1, -108(%rbp)
	jmp Lmain.6.end
	Lmain.6.false:
	movl $0, -108(%rbp)
	Lmain.6.end:
	cmpl $0, -108(%rbp)
	jE Lmain.7.false
	cmpl $1, -44(%rbp)
	movl $0, -112(%rbp)
	setE -112(%rbp)
	cmpl $0, -112(%rbp)
	jE Lmain.7.false
	movl $1, -116(%rbp)
	jmp Lmain.7.end
	Lmain.7.false:
	movl $0, -116(%rbp)
	Lmain.7.end:
	cmpl $0, -116(%rbp)
	jE Lmain.8.false
	cmpl $40, -48(%rbp)
	movl $0, -120(%rbp)
	setE -120(%rbp)
	cmpl $0, -120(%rbp)
	jE Lmain.8.false
	movl $1, -124(%rbp)
	jmp Lmain.8.end
	Lmain.8.false:
	movl $0, -124(%rbp)
	Lmain.8.end:
	movl -124(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
