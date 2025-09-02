	.globl _double_to_int
	.text
_double_to_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
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
	.globl _double_to_long
	.text
_double_to_long:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd %xmm0, -16(%rbp)
	cvttsd2siq -16(%rbp), %r11
	movq %r11, -24(%rbp)
	movq -24(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq $4746795990003587482, %r10
	movq %r10, %xmm0
	call _double_to_long
	movq %rax, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movq $2148429099, %r10
	cmpq %r10, -24(%rbp)
	movq $0, -32(%rbp)
	setNE -32(%rbp)
	cmpq $0, -32(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $4686111994867847738, %r10
	movq %r10, -40(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -40(%rbp)
	movsd -40(%rbp), %xmm0
	call _double_to_int
	movl %eax, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -48(%rbp)
	movl $200000, -52(%rbp)
	negl -52(%rbp)
	movl -52(%rbp), %r10d
	cmpl %r10d, -48(%rbp)
	movl $0, -56(%rbp)
	setNE -56(%rbp)
	cmpl $0, -56(%rbp)
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
