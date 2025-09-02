	.globl _non_zero
	.text
_non_zero:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd %xmm0, -16(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -24(%rbp)
	setE -24(%rbp)
	cvttsd2sil -24(%rbp), %r11d
	movl %r11d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _multiply_by_large_num
	.text
_multiply_by_large_num:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd %xmm0, -16(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -24(%rbp)
	movsd -24(%rbp), %xmm15
	movq $4910523509831470144, %r10
	movq %r10, %xmm14
	mulsd %xmm14, %xmm15
	movsd %xmm15, -24(%rbp)
	movsd -24(%rbp), %xmm0
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
	movq $5060, %r10
	movq %r10, -16(%rbp)
	movsd -16(%rbp), %xmm0
	call _multiply_by_large_num
	movsd %xmm0, -24(%rbp)
	movq $129137177503090306, %r10
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
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movsd -16(%rbp), %xmm0
	call _non_zero
	movl %eax, -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
