	.globl _inf
	.data
_inf:
	.quad 0x7ff0000000000000
	.globl _very_large
	.data
_very_large:
	.quad 0x7fefdcf158adbb99
	.globl _zero
	.bss
_zero:
	.zero 8

	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $128, %rsp
	movq $9218868437227405312, %r10
	movq %r10, %xmm14
	movsd _inf(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -16(%rbp)
	setNE -16(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movsd _very_large(%rip), %xmm14
	movsd _inf(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -24(%rbp)
	setBE -24(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movsd _very_large(%rip), %xmm14
	movsd %xmm14, -32(%rbp)
	movsd -32(%rbp), %xmm15
	movq $4621819117588971520, %r10
	movq %r10, %xmm14
	mulsd %xmm14, %xmm15
	movsd %xmm15, -32(%rbp)
	movsd _inf(%rip), %xmm14
	movsd -32(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -40(%rbp)
	setNE -40(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $4607182418800017408, %r10
	movq %r10, %rax
	movq $0, %rdx
	divsd _zero(%rip)
	movq %rax, -48(%rbp)
	movsd _inf(%rip), %xmm14
	movsd -48(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movsd _inf(%rip), %xmm14
	movsd %xmm14, -64(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -64(%rbp)
	movsd -64(%rbp), %xmm14
	movsd %xmm14, -72(%rbp)
	movq $4607182418800017408, %r10
	movq %r10, -80(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -80(%rbp)
	movsd -80(%rbp), %rax
	movq $0, %rdx
	divsd _zero(%rip)
	movq %rax, -88(%rbp)
	movsd -88(%rbp), %xmm14
	movsd %xmm14, -96(%rbp)
	movsd _very_large(%rip), %xmm14
	movsd %xmm14, -104(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -104(%rbp)
	movsd -104(%rbp), %xmm14
	movsd -72(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -112(%rbp)
	setAE -112(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -112(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movsd -96(%rbp), %xmm14
	movsd -72(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -120(%rbp)
	setNE -120(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -120(%rbp), %xmm15
	comisd %xmm14, %xmm15
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
