	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	movl $2, -4(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $3, -4(%rbp)
	Lmain.0.end:
	cmpl $0, -8(%rbp)
	jE Lmain.1.true
	movl $4, -8(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $5, -8(%rbp)
	Lmain.1.end:
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -8(%rbp), %r10d
	addl %r10d, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
