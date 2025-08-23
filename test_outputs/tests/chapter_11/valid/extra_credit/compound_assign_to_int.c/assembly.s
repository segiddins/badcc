	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $128, %rsp
	movl $20, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl $2147483647, -20(%rbp)
	movl $5000000, -24(%rbp)
	negl -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -16(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -36(%rbp)
	movq -36(%rbp), %r10
	movq %r10, -44(%rbp)
	movq $2147483648, %r10
	addq %r10, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -16(%rbp)
	cmpl $2147483628, -16(%rbp)
	movl $0, -52(%rbp)
	setNE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	cmpl $2147483647, -20(%rbp)
	movl $0, -56(%rbp)
	setNE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl -20(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -64(%rbp)
	movq $34359738367, %r10
	movq %r10, -72(%rbp)
	negq -72(%rbp)
	movq -64(%rbp), %rax
	cqo
	idivq -72(%rbp)
	movq %rax, -80(%rbp)
	movl -80(%rbp), %r10d
	movl %r10d, -84(%rbp)
	movl -84(%rbp), %r10d
	movl %r10d, -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	cmpl $2147483628, -16(%rbp)
	movl $0, -88(%rbp)
	setNE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $5000000, -92(%rbp)
	negl -92(%rbp)
	movl -92(%rbp), %r10d
	cmpl %r10d, -28(%rbp)
	movl $0, -96(%rbp)
	setNE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl -28(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -104(%rbp)
	movq -104(%rbp), %r10
	movq %r10, -112(%rbp)
	movq -112(%rbp), %r11
	imulq $10000, %r11
	movq %r11, -112(%rbp)
	movl -112(%rbp), %r10d
	movl %r10d, -116(%rbp)
	movl -116(%rbp), %r10d
	movl %r10d, -28(%rbp)
	cmpl $1539607552, -28(%rbp)
	movl $0, -120(%rbp)
	setNE -120(%rbp)
	cmpl $0, -120(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
