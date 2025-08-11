	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $60, %rsp
	movl $10, -4(%rbp)
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
	addl %r10d, -4(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.1.false
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.1.false
	movl $1, -16(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -16(%rbp)
	Lmain.1.end:
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -8(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -8(%rbp)
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
	subl %r10d, -20(%rbp)
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
	movl -28(%rbp), %eax
	cdq
	idivl -32(%rbp)
	movl %eax, -28(%rbp)
	cmpl $11, -4(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.4.false
	cmpl $0, -8(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.4.false
	movl $1, -44(%rbp)
	jmp Lmain.4.end
	Lmain.4.false:
	movl $0, -44(%rbp)
	Lmain.4.end:
	cmpl $0, -44(%rbp)
	jE Lmain.5.false
	cmpl $13, -20(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.5.false
	movl $1, -40(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -40(%rbp)
	Lmain.5.end:
	cmpl $0, -40(%rbp)
	jE Lmain.6.false
	cmpl $16, -28(%rbp)
	movl $0, -60(%rbp)
	setE -60(%rbp)
	cmpl $0, -60(%rbp)
	jE Lmain.6.false
	movl $1, -36(%rbp)
	jmp Lmain.6.end
	Lmain.6.false:
	movl $0, -36(%rbp)
	Lmain.6.end:
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
