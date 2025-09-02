	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $0, -12(%rbp)
	movq $4636737291354636288, %r10
	movq %r10, -20(%rbp)
	Lloop.0.cond:
	movq $0, %r10
	movq %r10, %xmm14
	movsd -20(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -28(%rbp)
	setA -28(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -28(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lloop.0
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	movsd -20(%rbp), %xmm14
	movsd %xmm14, -40(%rbp)
	movsd -40(%rbp), %xmm15
	movq $4607182418800017408, %r10
	movq %r10, %xmm14
	subsd %xmm14, %xmm15
	movsd %xmm15, -40(%rbp)
	movsd -40(%rbp), %xmm14
	movsd %xmm14, -20(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
