	.globl _non_zero
	.data
_non_zero:
	.quad 0x3bc79ca10c924223
	.globl _one
	.data
_one:
	.quad 0x3ff0000000000000
	.globl _rounded_to_zero
	.bss
_rounded_to_zero:
	.zero 8

	.globl _zero
	.bss
_zero:
	.zero 8

	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $112, %rsp
	movq $0, %r10
	movq %r10, %xmm14
	movsd _zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _rounded_to_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _non_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	jmp Lmain.2.end
	Lmain.2.true:
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.2.end:
	movq $0, %r10
	movq %r10, %xmm14
	movq $0, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _non_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -16(%rbp)
	setE -16(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
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
	movsd _zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -24(%rbp)
	setE -24(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -32(%rbp)
	setE -32(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -32(%rbp), %xmm15
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
	movq %r10, %xmm14
	movsd _rounded_to_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -40(%rbp)
	setE -40(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -48(%rbp)
	setE -48(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -48(%rbp), %xmm15
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
	movq %r10, %xmm14
	movsd _non_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.8.false
	movq $0, %r10
	movq %r10, %xmm14
	movq $4607182418800017408, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.8.false
	movl $1, -52(%rbp)
	jmp Lmain.8.end
	Lmain.8.false:
	movl $0, -52(%rbp)
	Lmain.8.end:
	cmpl $0, -52(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movq $0, %r10
	movq %r10, %xmm14
	movq $4613937818241073152, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.10.false
	movq $0, %r10
	movq %r10, %xmm14
	movsd _zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.10.false
	movl $1, -60(%rbp)
	jmp Lmain.10.end
	Lmain.10.false:
	movl $0, -60(%rbp)
	Lmain.10.end:
	cmpl $0, -60(%rbp)
	jE Lmain.9.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.9.end
	Lmain.9.true:
	Lmain.9.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _rounded_to_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.12.false
	movq $0, %r10
	movq %r10, %xmm14
	movq $4801453603149578240, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.12.false
	movl $1, -64(%rbp)
	jmp Lmain.12.end
	Lmain.12.false:
	movl $0, -64(%rbp)
	Lmain.12.end:
	cmpl $0, -64(%rbp)
	jE Lmain.11.true
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.11.end
	Lmain.11.true:
	Lmain.11.end:
	movq $0, %r10
	movq %r10, %xmm14
	movq $-4616189618054758400, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.14.false
	movq $0, %r10
	movq %r10, %xmm14
	movsd _zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.14.false
	movl $1, -68(%rbp)
	jmp Lmain.14.end
	Lmain.14.false:
	movl $0, -68(%rbp)
	Lmain.14.end:
	cmpl $0, -68(%rbp)
	jE Lmain.13.true
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.13.end
	Lmain.13.true:
	Lmain.13.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _non_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.16.false
	movq $0, %r10
	movq %r10, %xmm14
	movq $4617315517961601024, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.16.false
	movl $1, -72(%rbp)
	jmp Lmain.16.end
	Lmain.16.false:
	movl $0, -72(%rbp)
	Lmain.16.end:
	cmpl $0, -72(%rbp)
	movl $0, -76(%rbp)
	setE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lmain.15.true
	movl $11, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.15.end
	Lmain.15.true:
	Lmain.15.end:
	movq $0, %r10
	movq %r10, %xmm14
	movq $4617315517961601024, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.18.true
	movq $0, %r10
	movq %r10, %xmm14
	movsd _zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.18.true
	movl $0, -80(%rbp)
	jmp Lmain.18.end
	Lmain.18.true:
	movl $1, -80(%rbp)
	Lmain.18.end:
	cmpl $0, -80(%rbp)
	movl $0, -84(%rbp)
	setE -84(%rbp)
	cmpl $0, -84(%rbp)
	jE Lmain.17.true
	movl $12, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.17.end
	Lmain.17.true:
	Lmain.17.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.20.true
	movq $0, %r10
	movq %r10, %xmm14
	movsd _rounded_to_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.20.true
	movl $0, -88(%rbp)
	jmp Lmain.20.end
	Lmain.20.true:
	movl $1, -88(%rbp)
	Lmain.20.end:
	cmpl $0, -88(%rbp)
	jE Lmain.19.true
	movl $13, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.19.end
	Lmain.19.true:
	Lmain.19.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _rounded_to_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.22.true
	movq $0, %r10
	movq %r10, %xmm14
	movq $4547007122018943789, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.22.true
	movl $0, -92(%rbp)
	jmp Lmain.22.end
	Lmain.22.true:
	movl $1, -92(%rbp)
	Lmain.22.end:
	cmpl $0, -92(%rbp)
	movl $0, -96(%rbp)
	setE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lmain.21.true
	movl $14, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.21.end
	Lmain.21.true:
	Lmain.21.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _non_zero(%rip), %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.24.true
	movq $0, %r10
	movq %r10, %xmm14
	movq $0, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.24.true
	movl $0, -100(%rbp)
	jmp Lmain.24.end
	Lmain.24.true:
	movl $1, -100(%rbp)
	Lmain.24.end:
	cmpl $0, -100(%rbp)
	movl $0, -104(%rbp)
	setE -104(%rbp)
	cmpl $0, -104(%rbp)
	jE Lmain.23.true
	movl $15, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.23.end
	Lmain.23.true:
	Lmain.23.end:
	movq $0, %r10
	movq %r10, %xmm14
	movq $0, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.26.true
	movq $0, %r10
	movq %r10, %xmm14
	movq $4512825593480736141, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	jNE Lmain.26.true
	movl $0, -108(%rbp)
	jmp Lmain.26.end
	Lmain.26.true:
	movl $1, -108(%rbp)
	Lmain.26.end:
	cmpl $0, -108(%rbp)
	movl $0, -112(%rbp)
	setE -112(%rbp)
	cmpl $0, -112(%rbp)
	jE Lmain.25.true
	movl $16, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.25.end
	Lmain.25.true:
	Lmain.25.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
