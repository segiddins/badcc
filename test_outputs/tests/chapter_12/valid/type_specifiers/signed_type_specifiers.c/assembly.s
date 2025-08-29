	.data
_i:
	.long 5
	.globl _l
	.data
_l:
	.quad 7
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	cmpl $5, _i(%rip)
	movl $0, -12(%rbp)
	setNE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	cmpq $7, _l(%rip)
	movq $0, -20(%rbp)
	setNE -20(%rbp)
	cmpq $0, -20(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $0, -24(%rbp)
	movl $10, -28(%rbp)
	Lloop.0.cond:
	cmpl $0, -28(%rbp)
	movl $0, -32(%rbp)
	setG -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lloop.0
	movl -24(%rbp), %r10d
	movl %r10d, -36(%rbp)
	addl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -24(%rbp)
	Lloop.0.start:
	movl -28(%rbp), %r10d
	movl %r10d, -40(%rbp)
	subl $1, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -28(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $10, -24(%rbp)
	movl $0, -44(%rbp)
	setNE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
