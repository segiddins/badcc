	.data
_d.1:
	.quad 0x3fe8000000000000
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $176, %rsp
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, -16(%rbp)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd _d.1(%rip), %xmm15
	movq $4607182418800017408, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, _d.1(%rip)
	movq $4604930618986332160, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -24(%rbp)
	setNE -24(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $4610560118520545280, %r10
	movq %r10, %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -32(%rbp)
	setNE -32(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -32(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $4636751365103471821, %r10
	movq %r10, -40(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -40(%rbp)
	movsd -40(%rbp), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd _d.1(%rip), %xmm15
	movq $4607182418800017408, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, _d.1(%rip)
	movq $4636680996359294157, %r10
	movq %r10, -48(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -48(%rbp)
	movsd -48(%rbp), %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $4636680996359294157, %r10
	movq %r10, -64(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -64(%rbp)
	movsd -64(%rbp), %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -72(%rbp)
	setNE -72(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -72(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, -80(%rbp)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd _d.1(%rip), %xmm15
	movq $-4616189618054758400, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, _d.1(%rip)
	movq $4636680996359294157, %r10
	movq %r10, -88(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -88(%rbp)
	movsd -88(%rbp), %xmm14
	movsd -80(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -96(%rbp)
	setNE -96(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -96(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movq $4636751365103471821, %r10
	movq %r10, -104(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -104(%rbp)
	movsd -104(%rbp), %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -112(%rbp)
	setNE -112(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -112(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd _d.1(%rip), %xmm15
	movq $-4616189618054758400, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, _d.1(%rip)
	movq $4636821733847649485, %r10
	movq %r10, -120(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -120(%rbp)
	movsd -120(%rbp), %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -128(%rbp)
	setNE -128(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -128(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movq $4636821733847649485, %r10
	movq %r10, -136(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -136(%rbp)
	movsd -136(%rbp), %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -144(%rbp)
	setNE -144(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -144(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movq $4292743757239851855, %r10
	movq %r10, _d.1(%rip)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, -152(%rbp)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd _d.1(%rip), %xmm15
	movq $4607182418800017408, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, _d.1(%rip)
	movq $4607182418800017408, %r10
	movq %r10, %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -160(%rbp)
	setNE -160(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -160(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.8.true
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.8.end
	Lmain.8.true:
	Lmain.8.end:
	movq $4921056587992461136, %r10
	movq %r10, _d.1(%rip)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, -168(%rbp)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd _d.1(%rip), %xmm15
	movq $-4616189618054758400, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, _d.1(%rip)
	movq $4921056587992461136, %r10
	movq %r10, %xmm14
	movsd _d.1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -176(%rbp)
	setNE -176(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -176(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.9.true
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.9.end
	Lmain.9.true:
	Lmain.9.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
