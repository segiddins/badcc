	.globl _four
	.data
_four:
	.quad 0x4010000000000000
	.globl _point_one
	.data
_point_one:
	.quad 0x3fb999999999999a
	.globl _point_three
	.data
_point_three:
	.quad 0x3fd3333333333333
	.globl _point_two
	.data
_point_two:
	.quad 0x3fc999999999999a
	.globl _three
	.data
_three:
	.quad 0x4008000000000000
	.globl _twelveE30
	.data
_twelveE30:
	.quad 0x4662eec2eb3869af
	.globl _two
	.data
_two:
	.quad 0x4000000000000000
	.globl _addition
	.text
_addition:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd _point_one(%rip), %xmm14
	movsd %xmm14, -16(%rbp)
	movsd -16(%rbp), %xmm15
	addsd _point_two(%rip), %xmm15
	movsd %xmm15, -16(%rbp)
	movq $4599075939470750516, %r10
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
	.globl _subtraction
	.text
_subtraction:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd _four(%rip), %xmm14
	movsd %xmm14, -16(%rbp)
	movsd -16(%rbp), %xmm15
	movq $4607182418800017408, %r10
	movq %r10, %xmm14
	subsd %xmm14, %xmm15
	movsd %xmm15, -16(%rbp)
	movq $4613937818241073152, %r10
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
	.globl _multiplication
	.text
_multiplication:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $4576918229304087675, %r10
	movq %r10, -16(%rbp)
	movsd -16(%rbp), %xmm15
	mulsd _point_three(%rip), %xmm15
	movsd %xmm15, -16(%rbp)
	movq $4569063951553953530, %r10
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
	.globl _division
	.text
_division:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $4619567317775286272, %r10
	movq %r10, %rax
	movq $0, %rdx
	divsd _two(%rip)
	movq %rax, -16(%rbp)
	movq $4615063718147915776, %r10
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
	.globl _negation
	.text
_negation:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movsd _twelveE30(%rip), %xmm14
	movsd %xmm14, -16(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -16(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -24(%rbp)
	movq $5071878651310008751, %r10
	movq %r10, -32(%rbp)
	movsd -32(%rbp), %xmm15
	addsd -24(%rbp), %xmm15
	movsd %xmm15, -32(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -32(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -40(%rbp)
	setE -40(%rbp)
	cvttsd2sil -40(%rbp), %r11d
	movl %r11d, -44(%rbp)
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _complex_expression
	.text
_complex_expression:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movsd _two(%rip), %xmm14
	movsd %xmm14, -16(%rbp)
	movsd -16(%rbp), %xmm15
	addsd _three(%rip), %xmm15
	movsd %xmm15, -16(%rbp)
	movq $4638672431819522048, %r10
	movq %r10, -24(%rbp)
	movsd -24(%rbp), %xmm15
	mulsd _four(%rip), %xmm15
	movsd %xmm15, -24(%rbp)
	movsd -16(%rbp), %xmm14
	movsd %xmm14, -32(%rbp)
	movsd -32(%rbp), %xmm15
	subsd -24(%rbp), %xmm15
	movsd %xmm15, -32(%rbp)
	movsd -32(%rbp), %xmm14
	movsd %xmm14, -40(%rbp)
	movq $4647591670144040960, %r10
	movq %r10, -48(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -48(%rbp)
	movsd -48(%rbp), %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setE -56(%rbp)
	cvttsd2sil -56(%rbp), %r11d
	movl %r11d, -60(%rbp)
	movl -60(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	call _addition
	movl %eax, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	call _subtraction
	movl %eax, -20(%rbp)
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	call _multiplication
	movl %eax, -28(%rbp)
	cmpl $0, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	call _division
	movl %eax, -36(%rbp)
	cmpl $0, -36(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	call _negation
	movl %eax, -44(%rbp)
	cmpl $0, -44(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	call _complex_expression
	movl %eax, -52(%rbp)
	cmpl $0, -52(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.5.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
