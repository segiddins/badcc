	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $1, -12(%rbp)
	xorl $1, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $4, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $5, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	Lmain.0.end:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
