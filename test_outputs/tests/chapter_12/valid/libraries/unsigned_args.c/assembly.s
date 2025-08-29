	.globl _accept_unsigned
	.text
_accept_unsigned:
	pushq %rbp
	movq %rsp, %rbp
	subq $112, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movq %rdx, -24(%rbp)
	movq %rcx, -32(%rbp)
	movl %r8d, -36(%rbp)
	movl %r9d, -40(%rbp)
	movq 16(%rbp), %r10
	movq %r10, -48(%rbp)
	movl 24(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movq 32(%rbp), %r10
	movq %r10, -60(%rbp)
	cmpl $1, -12(%rbp)
	movl $0, -64(%rbp)
	setNE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Laccept_unsigned.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.0.end
	Laccept_unsigned.0.true:
	Laccept_unsigned.0.end:
	movl $4294967295, %r10d
	cmpl %r10d, -16(%rbp)
	movl $0, -68(%rbp)
	setNE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Laccept_unsigned.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.1.end
	Laccept_unsigned.1.true:
	Laccept_unsigned.1.end:
	cmpq $-1, -24(%rbp)
	movq $0, -76(%rbp)
	setNE -76(%rbp)
	cmpq $0, -76(%rbp)
	jE Laccept_unsigned.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.2.end
	Laccept_unsigned.2.true:
	Laccept_unsigned.2.end:
	movq $-9223372036854775808, %r10
	cmpq %r10, -32(%rbp)
	movq $0, -84(%rbp)
	setNE -84(%rbp)
	cmpq $0, -84(%rbp)
	jE Laccept_unsigned.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.3.end
	Laccept_unsigned.3.true:
	Laccept_unsigned.3.end:
	movl $2147483648, %r10d
	cmpl %r10d, -36(%rbp)
	movl $0, -88(%rbp)
	setNE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Laccept_unsigned.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.4.end
	Laccept_unsigned.4.true:
	Laccept_unsigned.4.end:
	cmpl $0, -40(%rbp)
	movl $0, -92(%rbp)
	setNE -92(%rbp)
	cmpl $0, -92(%rbp)
	jE Laccept_unsigned.5.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.5.end
	Laccept_unsigned.5.true:
	Laccept_unsigned.5.end:
	cmpq $123456, -48(%rbp)
	movq $0, -100(%rbp)
	setNE -100(%rbp)
	cmpq $0, -100(%rbp)
	jE Laccept_unsigned.6.true
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.6.end
	Laccept_unsigned.6.true:
	Laccept_unsigned.6.end:
	movl $2147487744, %r10d
	cmpl %r10d, -52(%rbp)
	movl $0, -104(%rbp)
	setNE -104(%rbp)
	cmpl $0, -104(%rbp)
	jE Laccept_unsigned.7.true
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.7.end
	Laccept_unsigned.7.true:
	Laccept_unsigned.7.end:
	movq $-9223372032559808512, %r10
	cmpq %r10, -60(%rbp)
	movq $0, -112(%rbp)
	setNE -112(%rbp)
	cmpq $0, -112(%rbp)
	jE Laccept_unsigned.8.true
	movl $11, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Laccept_unsigned.8.end
	Laccept_unsigned.8.true:
	Laccept_unsigned.8.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
