	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $1, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $3, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	cmpl $4, -4(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.false
	cmpl $4, -8(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.false
	movl $1, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -12(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
