	.data
_d.1:
	.quad 0x3fe0000000000000
	.globl _return_static_variable
	.text
_return_static_variable:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, -16(%rbp)
	movsd _d.1(%rip), %xmm14
	movsd %xmm14, -24(%rbp)
	movsd -24(%rbp), %xmm15
	movq $4607182418800017408, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, -24(%rbp)
	movsd -24(%rbp), %xmm14
	movsd %xmm14, _d.1(%rip)
	movsd -16(%rbp), %xmm0
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
	subq $80, %rsp
	call _return_static_variable
	movsd %xmm0, -16(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -24(%rbp)
	call _return_static_variable
	movsd %xmm0, -32(%rbp)
	movsd -32(%rbp), %xmm14
	movsd %xmm14, -40(%rbp)
	call _return_static_variable
	movsd %xmm0, -48(%rbp)
	movsd -48(%rbp), %xmm14
	movsd %xmm14, -56(%rbp)
	movq $4602678819172646912, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -64(%rbp)
	setNE -64(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -64(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $4609434218613702656, %r10
	movq %r10, %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -72(%rbp)
	setNE -72(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -72(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $4612811918334230528, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -80(%rbp)
	setNE -80(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -80(%rbp), %xmm15
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
