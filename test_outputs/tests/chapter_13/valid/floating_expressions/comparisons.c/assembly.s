	.globl _fifty_fiveE5
	.data
_fifty_fiveE5:
	.quad 0x4154fb1800000000
	.globl _fifty_fourE4
	.data
_fifty_fourE4:
	.quad 0x41207ac000000000
	.globl _four
	.data
_four:
	.quad 0x4010000000000000
	.globl _point_one
	.data
_point_one:
	.quad 0x3fb999999999999a
	.globl _tiny
	.data
_tiny:
	.quad 0x3f04f8b588e368f1
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $176, %rsp
	movsd _fifty_fourE4(%rip), %xmm14
	movsd _fifty_fiveE5(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -16(%rbp)
	setB -16(%rbp)
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
	movq $4616189618054758400, %r10
	movq %r10, %xmm14
	movsd _four(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -24(%rbp)
	setA -24(%rbp)
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
	movq $0, %r10
	movq %r10, %xmm14
	movsd _tiny(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -32(%rbp)
	setBE -32(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -32(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movsd _fifty_fiveE5(%rip), %xmm14
	movsd _fifty_fourE4(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -40(%rbp)
	setAE -40(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -40(%rbp), %xmm15
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
	movsd _tiny(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -48(%rbp)
	setE -48(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -48(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movsd _point_one(%rip), %xmm14
	movsd _point_one(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movq $4527516983983565041, %r10
	movq %r10, %xmm14
	movsd _tiny(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -64(%rbp)
	setA -64(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -64(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -72(%rbp)
	setE -72(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -72(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movq $4541027782865676529, %r10
	movq %r10, -80(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -80(%rbp)
	movsd _four(%rip), %xmm14
	movsd -80(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -88(%rbp)
	setB -88(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -88(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -96(%rbp)
	setE -96(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -96(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movsd _tiny(%rip), %xmm14
	movsd _tiny(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -104(%rbp)
	setBE -104(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -104(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -112(%rbp)
	setE -112(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -112(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.8.true
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.8.end
	Lmain.8.true:
	Lmain.8.end:
	movsd _fifty_fiveE5(%rip), %xmm14
	movsd _fifty_fiveE5(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -120(%rbp)
	setAE -120(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -120(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -128(%rbp)
	setE -128(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -128(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.9.true
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.9.end
	Lmain.9.true:
	Lmain.9.end:
	movq $4591870180066957722, %r10
	movq %r10, %xmm15
	comisd _point_one(%rip), %xmm15
	movq $0, -136(%rbp)
	setE -136(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -136(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -144(%rbp)
	setE -144(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -144(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.10.true
	movl $11, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.10.end
	Lmain.10.true:
	Lmain.10.end:
	movq $4539475662290099561, %r10
	movq %r10, %xmm14
	movsd _tiny(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -152(%rbp)
	setNE -152(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -152(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -160(%rbp)
	setE -160(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -160(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.11.true
	movl $12, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.11.end
	Lmain.11.true:
	Lmain.11.end:
	movq $4434466073940909850, %r10
	movq %r10, %xmm14
	movq $4539475662290099561, %r10
	movq %r10, %xmm15
	comisd %xmm14, %xmm15
	movq $0, -168(%rbp)
	setB -168(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -168(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.12.true
	movl $13, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.12.end
	Lmain.12.true:
	Lmain.12.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
