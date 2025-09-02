	.globl _zero
	.bss
_zero:
	.zero 8

	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $192, %rsp
	movsd _zero(%rip), %xmm14
	movsd %xmm14, -16(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -16(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -24(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -32(%rbp)
	setNE -32(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -32(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $4607182418800017408, %r10
	movq %r10, %rax
	movq $0, %rdx
	divsd -24(%rbp)
	movq %rax, -40(%rbp)
	movq $9218868437227405312, %r10
	movq %r10, -48(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -48(%rbp)
	movsd -48(%rbp), %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $10, -60(%rbp)
	negl -60(%rbp)
	movl -60(%rbp), %r10d
	cvtsi2sdl %r10d, %xmm15
	movl %xmm15, -68(%rbp)
	movsd -68(%rbp), %rax
	movq $0, %rdx
	divsd -24(%rbp)
	movq %rax, -76(%rbp)
	movq $9218868437227405312, %r10
	movq %r10, %xmm14
	movsd -76(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -84(%rbp)
	setNE -84(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -84(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $0, -88(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.false
	movl $1, -88(%rbp)
	movl -88(%rbp), %r10d
	cvtsi2sdl %r10d, %xmm15
	movl %xmm15, -96(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -96(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.false
	movl $1, -100(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -100(%rbp)
	Lmain.3.end:
	cmpl $0, -88(%rbp)
	jE Lmain.4.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.5.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movq $0, %r10
	movq %r10, -108(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -108(%rbp)
	movsd -108(%rbp), %xmm14
	movsd _zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -116(%rbp)
	setNE -116(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -116(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.6.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movq $0, %r10
	movq %r10, -124(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -124(%rbp)
	movq $4616189618054758400, %r10
	movq %r10, %xmm0
	movsd -124(%rbp), %xmm1
	call _copysign
	movsd %xmm0, -132(%rbp)
	movsd -132(%rbp), %xmm14
	movsd %xmm14, -140(%rbp)
	movq $4617315517961601024, %r10
	movq %r10, -148(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -148(%rbp)
	movsd -148(%rbp), %xmm0
	movq $0, %r10
	movq %r10, %xmm1
	call _copysign
	movsd %xmm0, -156(%rbp)
	movsd -156(%rbp), %xmm14
	movsd %xmm14, -164(%rbp)
	movq $4616189618054758400, %r10
	movq %r10, -172(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -172(%rbp)
	movsd -172(%rbp), %xmm14
	movsd -140(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -180(%rbp)
	setNE -180(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -180(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.7.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movq $4617315517961601024, %r10
	movq %r10, %xmm14
	movsd -164(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -188(%rbp)
	setNE -188(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -188(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.8.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.8.end
	Lmain.8.true:
	Lmain.8.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
