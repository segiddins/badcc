	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $1, -4(%rbp)
	movl $2, -8(%rbp)
	movl $0, -12(%rbp)
	movl -8(%rbp), %r10d
	cmpl %r10d, -4(%rbp)
	movl $0, -20(%rbp)
	setG -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	movl $5, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	cmpl $0, -12(%rbp)
	jE Lmain.1.true
	movl $6, -24(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $7, -24(%rbp)
	Lmain.1.end:
	movl -24(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lmain.0.end:
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
