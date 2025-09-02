	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq $4611686018427387904, %r10
	movq %r10, -16(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -24(%rbp)
	movsd -24(%rbp), %xmm15
	movq $4611686018427387904, %r10
	movq %r10, %xmm14
	mulsd %xmm14, %xmm15
	movsd %xmm15, -24(%rbp)
	movq $4616189618054758400, %r10
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
