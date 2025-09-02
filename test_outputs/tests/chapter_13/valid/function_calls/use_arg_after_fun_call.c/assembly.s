	.globl _fun
	.text
_fun:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movsd %xmm0, -16(%rbp)
	movq $4611686018427387904, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -24(%rbp)
	setA -24(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lfun.0.true
	movsd -16(%rbp), %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfun.0.end
	Lfun.0.true:
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -32(%rbp)
	movsd -32(%rbp), %xmm15
	movq $4611686018427387904, %r10
	movq %r10, %xmm14
	addsd %xmm14, %xmm15
	movsd %xmm15, -32(%rbp)
	movsd -32(%rbp), %xmm0
	call _fun
	movsd %xmm0, -40(%rbp)
	movsd -40(%rbp), %xmm14
	movsd %xmm14, -48(%rbp)
	movsd -48(%rbp), %xmm14
	movsd %xmm14, -56(%rbp)
	movsd -56(%rbp), %xmm15
	addsd -16(%rbp), %xmm15
	movsd %xmm15, -56(%rbp)
	movsd -56(%rbp), %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	Lfun.0.end:
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
	subq $32, %rsp
	movq $4607182418800017408, %r10
	movq %r10, %xmm0
	call _fun
	movsd %xmm0, -16(%rbp)
	cvttsd2sil -16(%rbp), %r11d
	movl %r11d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
