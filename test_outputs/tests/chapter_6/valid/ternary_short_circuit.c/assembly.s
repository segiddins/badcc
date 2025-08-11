	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $1, -4(%rbp)
	movl $0, -8(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	movl $1, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $2, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lmain.0.end:
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
