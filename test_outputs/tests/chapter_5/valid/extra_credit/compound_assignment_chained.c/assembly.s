	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $112, %rsp
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
	movl %edx, -32(%rbp)
	movl -24(%rbp), %eax
	cdq
	idivl -32(%rbp)
	movl %eax, -24(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %r11d
	imull -24(%rbp), %r11d
	movl %r11d, -20(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -20(%rbp), %r10d
	subl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -40(%rbp)
	cmpl $2250, -12(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.0.false
	cmpl $2000, -16(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.0.false
	movl $1, -56(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -56(%rbp)
	Lmain.0.end:
	cmpl $0, -56(%rbp)
	jE Lmain.1.false
	movl $1800, -60(%rbp)
	negl -60(%rbp)
	movl -60(%rbp), %r10d
	cmpl %r10d, -20(%rbp)
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
	movl $18, -72(%rbp)
	negl -72(%rbp)
	movl -72(%rbp), %r10d
	cmpl %r10d, -24(%rbp)
	movl $0, -76(%rbp)
	setE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lmain.2.false
	movl $1, -80(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -80(%rbp)
	Lmain.2.end:
	cmpl $0, -80(%rbp)
	jE Lmain.3.false
	movl $4, -84(%rbp)
	negl -84(%rbp)
	movl -84(%rbp), %r10d
	cmpl %r10d, -32(%rbp)
	movl $0, -88(%rbp)
	setE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Lmain.3.false
	movl $1, -92(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -92(%rbp)
	Lmain.3.end:
	cmpl $0, -92(%rbp)
	jE Lmain.4.false
	movl $7, -96(%rbp)
	negl -96(%rbp)
	movl -96(%rbp), %r10d
	cmpl %r10d, -36(%rbp)
	movl $0, -100(%rbp)
	setE -100(%rbp)
	cmpl $0, -100(%rbp)
	jE Lmain.4.false
	movl $1, -104(%rbp)
	jmp Lmain.4.end
	Lmain.4.false:
	movl $0, -104(%rbp)
	Lmain.4.end:
	cmpl $0, -104(%rbp)
	jE Lmain.5.false
	cmpl $2250, -40(%rbp)
	movl $0, -108(%rbp)
	setE -108(%rbp)
	cmpl $0, -108(%rbp)
	jE Lmain.5.false
	movl $1, -112(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -112(%rbp)
	Lmain.5.end:
	movl -112(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
