	.globl _x
_x:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movl %ecx, -24(%rbp)
	movl %r8d, -28(%rbp)
	movl %r9d, -32(%rbp)
	cmpl $1, -12(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lx.0.false
	cmpl $2, -16(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lx.0.false
	movl $1, -44(%rbp)
	jmp Lx.0.end
	Lx.0.false:
	movl $0, -44(%rbp)
	Lx.0.end:
	cmpl $0, -44(%rbp)
	jE Lx.1.false
	cmpl $3, -20(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lx.1.false
	movl $1, -52(%rbp)
	jmp Lx.1.end
	Lx.1.false:
	movl $0, -52(%rbp)
	Lx.1.end:
	cmpl $0, -52(%rbp)
	jE Lx.2.false
	cmpl $4, -24(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lx.2.false
	movl $1, -60(%rbp)
	jmp Lx.2.end
	Lx.2.false:
	movl $0, -60(%rbp)
	Lx.2.end:
	cmpl $0, -60(%rbp)
	jE Lx.3.false
	cmpl $5, -28(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lx.3.false
	movl $1, -68(%rbp)
	jmp Lx.3.end
	Lx.3.false:
	movl $0, -68(%rbp)
	Lx.3.end:
	cmpl $0, -68(%rbp)
	jE Lx.4.false
	cmpl $6, -32(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lx.4.false
	movl $1, -76(%rbp)
	jmp Lx.4.end
	Lx.4.false:
	movl $0, -76(%rbp)
	Lx.4.end:
	movl -76(%rbp), %eax
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
	subq $32, %rsp
	movl $4, -12(%rbp)
	movl -12(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -16(%rbp)
	movl $24, -20(%rbp)
	movl -20(%rbp), %r11d
	movl -16(%rbp), %ecx
	sarl %cl, %r11d
	movl %r11d, -20(%rbp)
	movl $1, %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $5, %r8d
	movl -20(%rbp), %r9d
	call _x
	movl %eax, -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
