	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $208, %rsp
	movq $4607182418800017408, %r10
	movq %r10, -16(%rbp)
	movq $4607182418800017408, %r10
	movq %r10, -24(%rbp)
	movq $4607182418800017408, %r10
	movq %r10, -32(%rbp)
	movq $4607182418800017408, %r10
	movq %r10, -40(%rbp)
	movsd -24(%rbp), %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -48(%rbp)
	setE -48(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -48(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.false
	movsd -32(%rbp), %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.false
	movl $1, -60(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -60(%rbp)
	Lmain.1.end:
	cmpl $0, -60(%rbp)
	jE Lmain.2.false
	movsd -40(%rbp), %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -68(%rbp)
	setE -68(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -68(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.false
	movl $1, -72(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -72(%rbp)
	Lmain.2.end:
	cmpl $0, -72(%rbp)
	movl $0, -76(%rbp)
	setE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -84(%rbp)
	movsd -84(%rbp), %xmm15
	addsd -24(%rbp), %xmm15
	movsd %xmm15, -84(%rbp)
	movsd -84(%rbp), %xmm14
	movsd %xmm14, -92(%rbp)
	movsd -92(%rbp), %xmm15
	addsd -32(%rbp), %xmm15
	movsd %xmm15, -92(%rbp)
	movsd -92(%rbp), %xmm14
	movsd %xmm14, -100(%rbp)
	movsd -100(%rbp), %xmm15
	addsd -40(%rbp), %xmm15
	movsd %xmm15, -100(%rbp)
	movq $4616189618054758400, %r10
	movq %r10, %xmm14
	movsd -100(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -108(%rbp)
	setNE -108(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -108(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $4593671619917905920, %r10
	movq %r10, -116(%rbp)
	movq $4593671619917905920, %r10
	movq %r10, -124(%rbp)
	movq $4593671619917905920, %r10
	movq %r10, -132(%rbp)
	movq $4593671619917905920, %r10
	movq %r10, -140(%rbp)
	movsd -124(%rbp), %xmm14
	movsd -116(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -148(%rbp)
	setE -148(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -148(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.5.false
	movsd -132(%rbp), %xmm14
	movsd -116(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -156(%rbp)
	setE -156(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -156(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.5.false
	movl $1, -160(%rbp)
	jmp Lmain.5.end
	Lmain.5.false:
	movl $0, -160(%rbp)
	Lmain.5.end:
	cmpl $0, -160(%rbp)
	jE Lmain.6.false
	movsd -140(%rbp), %xmm14
	movsd -116(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -168(%rbp)
	setE -168(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -168(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.6.false
	movl $1, -172(%rbp)
	jmp Lmain.6.end
	Lmain.6.false:
	movl $0, -172(%rbp)
	Lmain.6.end:
	cmpl $0, -172(%rbp)
	movl $0, -176(%rbp)
	setE -176(%rbp)
	cmpl $0, -176(%rbp)
	jE Lmain.4.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movsd -116(%rbp), %xmm14
	movsd %xmm14, -184(%rbp)
	movsd -184(%rbp), %xmm15
	addsd -124(%rbp), %xmm15
	movsd %xmm15, -184(%rbp)
	movsd -184(%rbp), %xmm14
	movsd %xmm14, -192(%rbp)
	movsd -192(%rbp), %xmm15
	addsd -132(%rbp), %xmm15
	movsd %xmm15, -192(%rbp)
	movsd -192(%rbp), %xmm14
	movsd %xmm14, -200(%rbp)
	movsd -200(%rbp), %xmm15
	addsd -140(%rbp), %xmm15
	movsd %xmm15, -200(%rbp)
	movq $4602678819172646912, %r10
	movq %r10, %xmm14
	movsd -200(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -208(%rbp)
	setNE -208(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -208(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.7.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
