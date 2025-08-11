	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $0, -4(%rbp)
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	cmpl %r10d, -4(%rbp)
	movl $0, -16(%rbp)
	setG -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $4, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $5, -8(%rbp)
	Lmain.0.end:
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
