	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $10, -12(%rbp)
	movl $0, -16(%rbp)
	movl $5, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $2, -20(%rbp)
	Lmain.0.end:
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	cmpl $5, -12(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.false
	cmpl $5, -16(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.1.false
	movl $1, -32(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -32(%rbp)
	Lmain.1.end:
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
