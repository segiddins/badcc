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
	movl %r10d, -52(%rbp)
	movl -36(%rbp), %r10d
	addl %r10d, -52(%rbp)
	movl -52(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -56(%rbp)
	movl -32(%rbp), %r10d
	xorl %r10d, -56(%rbp)
	movl -56(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -60(%rbp)
	movl -24(%rbp), %r10d
	orl %r10d, -60(%rbp)
	movl -60(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r11d
	imull -20(%rbp), %r11d
	movl %r11d, -64(%rbp)
	movl -64(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -68(%rbp)
	movl -16(%rbp), %r10d
	andl %r10d, -68(%rbp)
	movl -68(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -48(%rbp)
	cmpl $40, -12(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.0.false
	cmpl $21800, -16(%rbp)
	movl $0, -76(%rbp)
	setE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lmain.0.false
	movl $1, -80(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -80(%rbp)
	Lmain.0.end:
	cmpl $0, -80(%rbp)
	jE Lmain.1.false
	cmpl $109, -20(%rbp)
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
	cmpl $41, -24(%rbp)
	movl $0, -92(%rbp)
	setE -92(%rbp)
	cmpl $0, -92(%rbp)
	jE Lmain.2.false
	movl $1, -96(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -96(%rbp)
	Lmain.2.end:
	cmpl $0, -96(%rbp)
	jE Lmain.3.false
	cmpl $41, -28(%rbp)
	movl $0, -100(%rbp)
	setE -100(%rbp)
	cmpl $0, -100(%rbp)
	jE Lmain.3.false
	movl $1, -104(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -104(%rbp)
	Lmain.3.end:
	cmpl $0, -104(%rbp)
	jE Lmain.4.false
	cmpl $27, -32(%rbp)
	movl $0, -108(%rbp)
	setE -108(%rbp)
	cmpl $0, -108(%rbp)
	jE Lmain.4.false
	movl $1, -112(%rbp)
	jmp Lmain.4.end
	Lmain.4.false:
	movl $0, -112(%rbp)
	Lmain.4.end:
	cmpl $0, -112(%rbp)
	jE Lmain.5.false
	cmpl $2, -36(%rbp)
	movl $0, -116(%rbp)
	setE -116(%rbp)
	cmpl $0, -116(%rbp)
	jE Lmain.5.false
	movl $1, -120(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -120(%rbp)
	Lmain.5.end:
	cmpl $0, -120(%rbp)
	jE Lmain.6.false
	cmpl $2, -40(%rbp)
	movl $0, -124(%rbp)
	setE -124(%rbp)
	cmpl $0, -124(%rbp)
	jE Lmain.6.false
	movl $1, -128(%rbp)
	jmp Lmain.6.end
	Lmain.6.false:
	movl $0, -128(%rbp)
	Lmain.6.end:
	cmpl $0, -128(%rbp)
	jE Lmain.7.false
	cmpl $1, -44(%rbp)
	movl $0, -132(%rbp)
	setE -132(%rbp)
	cmpl $0, -132(%rbp)
	jE Lmain.7.false
	movl $1, -136(%rbp)
	jmp Lmain.7.end
	Lmain.7.false:
	movl $0, -136(%rbp)
	Lmain.7.end:
	cmpl $0, -136(%rbp)
	jE Lmain.8.false
	cmpl $40, -48(%rbp)
	movl $0, -140(%rbp)
	setE -140(%rbp)
	cmpl $0, -140(%rbp)
	jE Lmain.8.false
	movl $1, -144(%rbp)
	jmp Lmain.8.end
	Lmain.8.false:
	movl $0, -144(%rbp)
	Lmain.8.end:
	movl -144(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
