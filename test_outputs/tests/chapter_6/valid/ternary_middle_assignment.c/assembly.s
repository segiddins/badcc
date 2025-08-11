	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $1, -4(%rbp)
	cmpl $2, -4(%rbp)
	movl $0, -12(%rbp)
	setNE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $2, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $0, -8(%rbp)
	Lmain.0.end:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
