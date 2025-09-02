	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq $4617315517961601024, %r10
	movq %r10, %xmm0
	movq $4936209963552724370, %r10
	movq %r10, %xmm1
	movq $4705844345939427328, %r10
	movq %r10, %xmm2
	call _fma
	movsd %xmm0, -16(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -24(%rbp)
	movl $5, %edi
	movq $5728655265632406216, %r10
	movq %r10, %xmm0
	call _ldexp
	movsd %xmm0, -32(%rbp)
	movsd -32(%rbp), %xmm14
	movsd %xmm14, -40(%rbp)
	movq $4946409255702973175, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -48(%rbp)
	setNE -48(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -48(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $5751173263769258696, %r10
	movq %r10, %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
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
