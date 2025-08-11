	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $5, -4(%rbp)
	cmpl $4, -4(%rbp)
	movl $0, -8(%rbp)
	setG -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lmain.0.true
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	subl $4, -4(%rbp)
	movl $5, -12(%rbp)
	cmpl $4, -12(%rbp)
	movl $0, -16(%rbp)
	setG -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.1.true
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	subl $4, -12(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
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
