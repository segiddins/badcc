	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $76, %rsp
	movl $11, -4(%rbp)
	movl $12, -8(%rbp)
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lmain.0.true
	cmpl $0, -8(%rbp)
	jNE Lmain.0.true
	movl $0, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $1, -12(%rbp)
	Lmain.0.end:
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -12(%rbp), %r10d
	andl %r10d, -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lmain.1.true
	movl $1, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $0, -16(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $1, -16(%rbp)
	Lmain.1.end:
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -16(%rbp), %r10d
	xorl %r10d, -8(%rbp)
	movl $14, -20(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lmain.2.true
	cmpl $0, -8(%rbp)
	jNE Lmain.2.true
	movl $0, -24(%rbp)
	jmp Lmain.2.end
	Lmain.2.true:
	movl $1, -24(%rbp)
	Lmain.2.end:
	movl -20(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -24(%rbp), %r10d
	orl %r10d, -20(%rbp)
	movl $16, -28(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lmain.3.true
	cmpl $0, -28(%rbp)
	jNE Lmain.3.true
	movl $0, -32(%rbp)
	jmp Lmain.3.end
	Lmain.3.true:
	movl $1, -32(%rbp)
	Lmain.3.end:
	movl -28(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r11d
	movl -32(%rbp), %ecx
	sarl %cl, %r11d
	movl %r11d, -28(%rbp)
	movl $18, -36(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lmain.4.true
	cmpl $0, -28(%rbp)
	jNE Lmain.4.true
	movl $0, -40(%rbp)
	jmp Lmain.4.end
	Lmain.4.true:
	movl $1, -40(%rbp)
	Lmain.4.end:
	movl -36(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r11d
	movl -40(%rbp), %ecx
	sall %cl, %r11d
	movl %r11d, -36(%rbp)
	cmpl $1, -4(%rbp)
	movl $0, -60(%rbp)
	setE -60(%rbp)
	cmpl $0, -60(%rbp)
	jE Lmain.5.false
	cmpl $13, -8(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.5.false
	movl $1, -56(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -56(%rbp)
	Lmain.5.end:
	cmpl $0, -56(%rbp)
	jE Lmain.6.false
	cmpl $15, -20(%rbp)
	movl $0, -68(%rbp)
	setE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.6.false
	movl $1, -52(%rbp)
	jmp Lmain.6.end
	Lmain.6.false:
	movl $0, -52(%rbp)
	Lmain.6.end:
	cmpl $0, -52(%rbp)
	jE Lmain.7.false
	cmpl $8, -28(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.7.false
	movl $1, -48(%rbp)
	jmp Lmain.7.end
	Lmain.7.false:
	movl $0, -48(%rbp)
	Lmain.7.end:
	cmpl $0, -48(%rbp)
	jE Lmain.8.false
	cmpl $36, -36(%rbp)
	movl $0, -76(%rbp)
	setE -76(%rbp)
	cmpl $0, -76(%rbp)
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
