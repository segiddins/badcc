	.globl _int_to_double
	.text
_int_to_double:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl -12(%rbp), %r10d
	cvtsi2sdl %r10d, %xmm15
	movl %xmm15, -20(%rbp)
	movsd -20(%rbp), %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %r10
	movq %r10, %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _long_to_double
	.text
_long_to_double:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, -16(%rbp)
	movq -16(%rbp), %r10
	cvtsi2sdq %r10, %xmm15
	movq %xmm15, -24(%rbp)
	movsd -24(%rbp), %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %r10
	movq %r10, %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $96, %rsp
	movl $100000, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %edi
	call _int_to_double
	movsd %xmm0, -20(%rbp)
	movq $4681608360884174848, %r10
	movq %r10, -28(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -28(%rbp)
	movsd -28(%rbp), %xmm14
	movsd -20(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -36(%rbp)
	setNE -36(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -36(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $9007199254751227, %r10
	movq %r10, -44(%rbp)
	negq -44(%rbp)
	movq -44(%rbp), %rdi
	call _long_to_double
	movsd %xmm0, -52(%rbp)
	movq $4845873199050658814, %r10
	movq %r10, -60(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -60(%rbp)
	movsd -60(%rbp), %xmm14
	movsd -52(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -68(%rbp)
	setNE -68(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -68(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $1152921504606846977, %r10
	cvtsi2sdq %r10, %xmm15
	movq %xmm15, -76(%rbp)
	movsd -76(%rbp), %xmm14
	movsd %xmm14, -84(%rbp)
	movq $4877398396442247168, %r10
	movq %r10, %xmm14
	movsd -84(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -92(%rbp)
	setNE -92(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -92(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
