	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl $1, -16(%rbp)
	negl -16(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -20(%rbp)
	setG -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	movl $4, -24(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $5, -24(%rbp)
	Lmain.0.end:
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
