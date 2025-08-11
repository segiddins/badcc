	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $10, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	subl $10, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $0, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl -4(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $-1, -4(%rbp)
	movl -16(%rbp), %r10d
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
