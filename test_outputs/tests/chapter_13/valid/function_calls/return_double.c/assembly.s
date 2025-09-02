	.globl _d
	.text
_d:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq $5775110498327918383, %r10
	movq %r10, %xmm0
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
	subq $48, %rsp
	call _d
	movsd %xmm0, -16(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -24(%rbp)
	movq $5775110498327918383, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -32(%rbp)
	setE -32(%rbp)
	cvttsd2sil -32(%rbp), %r11d
	movl %r11d, -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
