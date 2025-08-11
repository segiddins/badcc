	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $104, %rsp
	movl $250, -4(%rbp)
	movl $200, -8(%rbp)
	movl $100, -12(%rbp)
	movl $75, -16(%rbp)
	movl $25, -24(%rbp)
	negl -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl $0, -28(%rbp)
	movl $0, -32(%rbp)
	movl $7, -36(%rbp)
	negl -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -20(%rbp), %eax
	cdq
	idivl -28(%rbp)
	movl %edx, -20(%rbp)
	movl -16(%rbp), %eax
	cdq
	idivl -20(%rbp)
	movl %eax, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -12(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -12(%rbp), %r10d
	subl %r10d, -8(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -8(%rbp), %r10d
	addl %r10d, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -32(%rbp)
	cmpl $2250, -4(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.0.false
	cmpl $2000, -8(%rbp)
	movl $0, -68(%rbp)
	setE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.0.false
	movl $1, -60(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -60(%rbp)
	Lmain.0.end:
	cmpl $0, -60(%rbp)
	jE Lmain.1.false
	movl $1800, -72(%rbp)
	negl -72(%rbp)
	movl -72(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -76(%rbp)
	setE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lmain.1.false
	movl $1, -56(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -56(%rbp)
	Lmain.1.end:
	cmpl $0, -56(%rbp)
	jE Lmain.2.false
	movl $18, -80(%rbp)
	negl -80(%rbp)
	movl -80(%rbp), %r10d
	cmpl %r10d, -16(%rbp)
	movl $0, -84(%rbp)
	setE -84(%rbp)
	cmpl $0, -84(%rbp)
	jE Lmain.2.false
	movl $1, -52(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -52(%rbp)
	Lmain.2.end:
	cmpl $0, -52(%rbp)
	jE Lmain.3.false
	movl $4, -88(%rbp)
	negl -88(%rbp)
	movl -88(%rbp), %r10d
	cmpl %r10d, -20(%rbp)
	movl $0, -92(%rbp)
	setE -92(%rbp)
	cmpl $0, -92(%rbp)
	jE Lmain.3.false
	movl $1, -48(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -48(%rbp)
	Lmain.3.end:
	cmpl $0, -48(%rbp)
	jE Lmain.4.false
	movl $7, -96(%rbp)
	negl -96(%rbp)
	movl -96(%rbp), %r10d
	cmpl %r10d, -28(%rbp)
	movl $0, -100(%rbp)
	setE -100(%rbp)
	cmpl $0, -100(%rbp)
	jE Lmain.4.false
	movl $1, -44(%rbp)
	jmp Lmain.4.end
	Lmain.4.false:
	movl $0, -44(%rbp)
	Lmain.4.end:
	cmpl $0, -44(%rbp)
	jE Lmain.5.false
	cmpl $2250, -32(%rbp)
	movl $0, -104(%rbp)
	setE -104(%rbp)
	cmpl $0, -104(%rbp)
	jE Lmain.5.false
	movl $1, -40(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -40(%rbp)
	Lmain.5.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
