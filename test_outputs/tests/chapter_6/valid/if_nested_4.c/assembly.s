	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $0, -4(%rbp)
	cmpl $0, -4(%rbp)
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lmain.0.true
	movl $3, %eax
	cdq
	movl $4, %r10d
	idivl %r10d
	movl %eax, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.1.true
	movl $3, -4(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $8, %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lmain.1.end:
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
