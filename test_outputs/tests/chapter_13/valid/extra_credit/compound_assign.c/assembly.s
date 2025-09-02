	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq $4621819117588971520, %r10
	movq %r10, -16(%rbp)
	movsd -16(%rbp), %rax
	movq $0, %rdx
	movq $4616189618054758400, %r10
	movq %r10, %r10
	divsd %r10
	movq %rax, -24(%rbp)
	movsd -24(%rbp), %xmm14
	movsd %xmm14, -16(%rbp)
	movq $4612811918334230528, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
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
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -40(%rbp)
	movsd -40(%rbp), %xmm15
	movq $4666723172467343360, %r10
	movq %r10, %xmm14
	mulsd %xmm14, %xmm15
	movsd %xmm15, -40(%rbp)
	movsd -40(%rbp), %xmm14
	movsd %xmm14, -16(%rbp)
	movq $4672601161629433856, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -48(%rbp)
	setNE -48(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -48(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
