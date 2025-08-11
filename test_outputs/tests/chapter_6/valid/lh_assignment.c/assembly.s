	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $10, -4(%rbp)
	movl $0, -8(%rbp)
	movl $5, -4(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $2, -12(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -8(%rbp)
	cmpl $5, -4(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.1.false
	cmpl $5, -8(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.false
	movl $1, -16(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -16(%rbp)
	Lmain.1.end:
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
