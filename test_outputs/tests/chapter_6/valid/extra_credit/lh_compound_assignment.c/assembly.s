	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $10, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	subl $1, -4(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	movl -4(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $0, -8(%rbp)
	Lmain.0.end:
	cmpl $4, -4(%rbp)
	movl $0, -12(%rbp)
	setE -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
