	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $4906019910204099648, %r10
	movq %r10, %xmm14
	movsd _d(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -16(%rbp)
	setE -16(%rbp)
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
