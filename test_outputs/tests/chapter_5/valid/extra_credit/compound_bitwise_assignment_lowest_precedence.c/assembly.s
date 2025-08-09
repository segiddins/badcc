	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $96, %rsp
	movl $11, -12(%rbp)
	movl $12, -16(%rbp)
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lmain.0.true
	cmpl $0, -16(%rbp)
	jNE Lmain.0.true
	movl $0, -20(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $1, -20(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -20(%rbp), %r10d
	andl %r10d, -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lmain.1.true
	movl $1, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $0, -24(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $1, -24(%rbp)
	Lmain.1.end:
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -24(%rbp), %r10d
	xorl %r10d, -16(%rbp)
	movl $14, -28(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lmain.2.true
	cmpl $0, -16(%rbp)
	jNE Lmain.2.true
	movl $0, -32(%rbp)
	jmp Lmain.2.end
	Lmain.2.true:
	movl $1, -32(%rbp)
	Lmain.2.end:
	movl -28(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -32(%rbp), %r10d
	orl %r10d, -28(%rbp)
	movl $16, -36(%rbp)
	cmpl $0, -28(%rbp)
	jNE Lmain.3.true
	cmpl $0, -36(%rbp)
	jNE Lmain.3.true
	movl $0, -40(%rbp)
	jmp Lmain.3.end
	Lmain.3.true:
	movl $1, -40(%rbp)
	Lmain.3.end:
	movl -36(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r11d
	movl -40(%rbp), %ecx
	sarl %cl, %r11d
	movl %r11d, -36(%rbp)
	movl $18, -44(%rbp)
	cmpl $0, -28(%rbp)
	jNE Lmain.4.true
	cmpl $0, -36(%rbp)
	jNE Lmain.4.true
	movl $0, -48(%rbp)
	jmp Lmain.4.end
	Lmain.4.true:
	movl $1, -48(%rbp)
	Lmain.4.end:
	movl -44(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -44(%rbp), %r11d
	movl -48(%rbp), %ecx
	sall %cl, %r11d
	movl %r11d, -44(%rbp)
	cmpl $1, -12(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.5.false
	cmpl $13, -16(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.5.false
	movl $1, -60(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -60(%rbp)
	Lmain.5.end:
	cmpl $0, -60(%rbp)
	jE Lmain.6.false
	cmpl $15, -28(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.6.false
	movl $1, -68(%rbp)
	jmp Lmain.6.end
	Lmain.6.false:
	movl $0, -68(%rbp)
	Lmain.6.end:
	cmpl $0, -68(%rbp)
	jE Lmain.7.false
	cmpl $8, -36(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.7.false
	movl $1, -76(%rbp)
	jmp Lmain.7.end
	Lmain.7.false:
	movl $0, -76(%rbp)
	Lmain.7.end:
	cmpl $0, -76(%rbp)
	jE Lmain.8.false
	cmpl $36, -44(%rbp)
	movl $0, -80(%rbp)
	setE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lmain.8.false
	movl $1, -84(%rbp)
	jmp Lmain.8.end
	Lmain.8.false:
	movl $0, -84(%rbp)
	Lmain.8.end:
	movl -84(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
