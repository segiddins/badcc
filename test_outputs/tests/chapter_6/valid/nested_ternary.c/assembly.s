	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	movl $2, -16(%rbp)
	movl $0, -20(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -24(%rbp)
	setG -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.true
	movl $5, -28(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	cmpl $0, -20(%rbp)
	jE Lmain.1.true
	movl $6, -32(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $7, -32(%rbp)
	Lmain.1.end:
	movl -32(%rbp), %r10d
	movl %r10d, -28(%rbp)
	Lmain.0.end:
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
