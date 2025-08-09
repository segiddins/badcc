	.globl _g
_g:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movl %ecx, -24(%rbp)
	cmpl $2, -12(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lg.1.false
	cmpl $4, -16(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lg.1.false
	movl $1, -36(%rbp)
	jmp Lg.1.end
	Lg.1.false:
	movl $0, -36(%rbp)
	Lg.1.end:
	cmpl $0, -36(%rbp)
	jE Lg.2.false
	cmpl $6, -20(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lg.2.false
	movl $1, -44(%rbp)
	jmp Lg.2.end
	Lg.2.false:
	movl $0, -44(%rbp)
	Lg.2.end:
	cmpl $0, -44(%rbp)
	jE Lg.3.false
	cmpl $8, -24(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lg.3.false
	movl $1, -52(%rbp)
	jmp Lg.3.end
	Lg.3.false:
	movl $0, -52(%rbp)
	Lg.3.end:
	cmpl $0, -52(%rbp)
	jE Lg.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lg.0.end
	Lg.0.true:
	Lg.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _f
_f:
	pushq %rbp
	movq %rsp, %rbp
	subq $96, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movl %ecx, -24(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -28(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -32(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -32(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -36(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -40(%rbp)
	movl -28(%rbp), %edi
	movl -32(%rbp), %esi
	movl -36(%rbp), %edx
	movl -40(%rbp), %ecx
	call _g
	movl %eax, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -48(%rbp)
	cmpl $1, -48(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lf.0.false
	cmpl $1, -12(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lf.0.false
	movl $1, -60(%rbp)
	jmp Lf.0.end
	Lf.0.false:
	movl $0, -60(%rbp)
	Lf.0.end:
	cmpl $0, -60(%rbp)
	jE Lf.1.false
	cmpl $2, -16(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lf.1.false
	movl $1, -68(%rbp)
	jmp Lf.1.end
	Lf.1.false:
	movl $0, -68(%rbp)
	Lf.1.end:
	cmpl $0, -68(%rbp)
	jE Lf.2.false
	cmpl $3, -20(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lf.2.false
	movl $1, -76(%rbp)
	jmp Lf.2.end
	Lf.2.false:
	movl $0, -76(%rbp)
	Lf.2.end:
	cmpl $0, -76(%rbp)
	jE Lf.3.false
	cmpl $4, -24(%rbp)
	movl $0, -80(%rbp)
	setE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lf.3.false
	movl $1, -84(%rbp)
	jmp Lf.3.end
	Lf.3.false:
	movl $0, -84(%rbp)
	Lf.3.end:
	movl -84(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	call _f
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
