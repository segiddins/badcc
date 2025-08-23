	.bss
_a:
	.zero 8

	.globl _my_function
	.text
_my_function:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
	movq %rdx, -32(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -40(%rbp)
	movq -24(%rbp), %r10
	addq %r10, -40(%rbp)
	movq -40(%rbp), %r10
	movq %r10, -48(%rbp)
	movq -32(%rbp), %r10
	addq %r10, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movl -52(%rbp), %eax
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
	subq $112, %rsp
	movq $1, -16(%rbp)
	movq $2, -24(%rbp)
	movq $3, -32(%rbp)
	movq $4, _a(%rip)
	movl $0, -36(%rbp)
	movq $1099511627776, %r10
	movq %r10, -44(%rbp)
	Lloop.0.cond:
	cmpq $0, -44(%rbp)
	movq $0, -52(%rbp)
	setG -52(%rbp)
	cmpq $0, -52(%rbp)
	jE Lloop.0
	movl -36(%rbp), %r10d
	movl %r10d, -56(%rbp)
	addl $1, -56(%rbp)
	movl -56(%rbp), %r10d
	movl %r10d, -36(%rbp)
	Lloop.0.start:
	movq -44(%rbp), %rax
	cqo
	movq $2, %r10
	idivq %r10
	movq %rax, -64(%rbp)
	movq -64(%rbp), %r10
	movq %r10, -44(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpq $1, -16(%rbp)
	movq $0, -72(%rbp)
	setNE -72(%rbp)
	cmpq $0, -72(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	cmpq $2, -24(%rbp)
	movq $0, -80(%rbp)
	setNE -80(%rbp)
	cmpq $0, -80(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	cmpq $4, _a(%rip)
	movq $0, -88(%rbp)
	setNE -88(%rbp)
	cmpq $0, -88(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rsi
	movq -32(%rbp), %rdx
	call _my_function
	movl %eax, -92(%rbp)
	cmpl $6, -92(%rbp)
	movl $0, -96(%rbp)
	setNE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	cmpl $41, -36(%rbp)
	movl $0, -100(%rbp)
	setNE -100(%rbp)
	cmpl $0, -100(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
