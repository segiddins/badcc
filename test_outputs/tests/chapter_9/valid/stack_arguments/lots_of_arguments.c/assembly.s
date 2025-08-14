	.globl _foo
	.text
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $112, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movl %ecx, -24(%rbp)
	movl %r8d, -28(%rbp)
	movl %r9d, -32(%rbp)
	movl 16(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl 24(%rbp), %r10d
	movl %r10d, -40(%rbp)
	cmpl $1, -12(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lfoo.0.false
	cmpl $2, -16(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lfoo.0.false
	movl $1, -52(%rbp)
	jmp Lfoo.0.end
	Lfoo.0.false:
	movl $0, -52(%rbp)
	Lfoo.0.end:
	cmpl $0, -52(%rbp)
	jE Lfoo.1.false
	cmpl $3, -20(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lfoo.1.false
	movl $1, -60(%rbp)
	jmp Lfoo.1.end
	Lfoo.1.false:
	movl $0, -60(%rbp)
	Lfoo.1.end:
	cmpl $0, -60(%rbp)
	jE Lfoo.2.false
	cmpl $4, -24(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lfoo.2.false
	movl $1, -68(%rbp)
	jmp Lfoo.2.end
	Lfoo.2.false:
	movl $0, -68(%rbp)
	Lfoo.2.end:
	cmpl $0, -68(%rbp)
	jE Lfoo.3.false
	cmpl $5, -28(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lfoo.3.false
	movl $1, -76(%rbp)
	jmp Lfoo.3.end
	Lfoo.3.false:
	movl $0, -76(%rbp)
	Lfoo.3.end:
	cmpl $0, -76(%rbp)
	jE Lfoo.4.false
	cmpl $6, -32(%rbp)
	movl $0, -80(%rbp)
	setE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lfoo.4.false
	movl $1, -84(%rbp)
	jmp Lfoo.4.end
	Lfoo.4.false:
	movl $0, -84(%rbp)
	Lfoo.4.end:
	cmpl $0, -84(%rbp)
	jE Lfoo.5.false
	cmpl $7, -36(%rbp)
	movl $0, -88(%rbp)
	setE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Lfoo.5.false
	movl $1, -92(%rbp)
	jmp Lfoo.5.end
	Lfoo.5.false:
	movl $0, -92(%rbp)
	Lfoo.5.end:
	cmpl $0, -92(%rbp)
	jE Lfoo.6.false
	cmpl $8, -40(%rbp)
	movl $0, -96(%rbp)
	setE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lfoo.6.false
	movl $1, -100(%rbp)
	jmp Lfoo.6.end
	Lfoo.6.false:
	movl $0, -100(%rbp)
	Lfoo.6.end:
	movl -100(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $5, %r8d
	movl $6, %r9d
	pushq $8
	pushq $7
	call _foo
	addq $16, %rsp
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
