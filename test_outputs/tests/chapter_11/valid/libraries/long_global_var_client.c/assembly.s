	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	call _return_l
	movq %rax, -16(%rbp)
	movq $8589934592, %r10
	cmpq %r10, -16(%rbp)
	movq $0, -24(%rbp)
	setNE -24(%rbp)
	cmpq $0, -24(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	call _return_l_as_int
	movl %eax, -28(%rbp)
	cmpl $0, -28(%rbp)
	movl $0, -32(%rbp)
	setNE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq _l(%rip), %r10
	movq %r10, -40(%rbp)
	subq $10, -40(%rbp)
	movq -40(%rbp), %r10
	movq %r10, _l(%rip)
	call _return_l
	movq %rax, -48(%rbp)
	movq $8589934582, %r10
	cmpq %r10, -48(%rbp)
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	cmpq $0, -56(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	call _return_l_as_int
	movl %eax, -60(%rbp)
	movl $10, -64(%rbp)
	negl -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -60(%rbp)
	movl $0, -68(%rbp)
	setNE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
