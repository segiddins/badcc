	.globl _check_args
	.text
_check_args:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq %rdi, -16(%rbp)
	movsd %xmm0, -24(%rbp)
	cmpq $2, -16(%rbp)
	movq $0, -32(%rbp)
	setE -32(%rbp)
	movq -32(%rbp), %r10
	cvtsi2sdq %r10, %xmm15
	movq %xmm15, -40(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lcheck_args.0.false
	movq $4618441417868443648, %r10
	movq %r10, -48(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -48(%rbp)
	movsd -48(%rbp), %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lcheck_args.0.false
	movl $1, -60(%rbp)
	jmp Lcheck_args.0.end
	Lcheck_args.0.false:
	movl $0, -60(%rbp)
	Lcheck_args.0.end:
	movl -60(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _return_double
	.text
_return_double:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq $-4594234569871327232, %r10
	movq %r10, %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %r10
	movq %r10, %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _check_assignment
	.text
_check_assignment:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd %xmm0, -16(%rbp)
	movl $0, -20(%rbp)
	cvttsd2sil -16(%rbp), %r11d
	movl %r11d, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -20(%rbp)
	cmpl $4, -20(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	movl -28(%rbp), %eax
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
	subq $80, %rsp
	movl $6, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	cvtsi2sdl %r10d, %xmm15
	movl %xmm15, -20(%rbp)
	movq $2, %rdi
	movsd -20(%rbp), %xmm0
	call _check_args
	movl %eax, -24(%rbp)
	cmpl $0, -24(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	call _return_double
	movsd %xmm0, -36(%rbp)
	movq $4895412794951729152, %r10
	movq %r10, %xmm14
	movsd -36(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -44(%rbp)
	setNE -44(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -44(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $4617202927970916762, %r10
	movq %r10, %xmm0
	call _check_assignment
	movl %eax, -48(%rbp)
	cmpl $0, -48(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $-4594234569871327232, %r10
	movq %r10, -60(%rbp)
	movq $4895412794951729152, %r10
	movq %r10, %xmm14
	movsd -60(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -68(%rbp)
	setNE -68(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -68(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
