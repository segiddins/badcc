	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $5, -12(%rbp)
	cmpl $4, -12(%rbp)
	movl $0, -16(%rbp)
	setG -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	subl $4, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl $5, -24(%rbp)
	cmpl $4, -24(%rbp)
	movl $0, -28(%rbp)
	setG -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.1.true
	movl -24(%rbp), %r10d
	movl %r10d, -32(%rbp)
	subl $4, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -24(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
