	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $28, %rsp
	movl $1, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $1, -4(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -8(%rbp)
	cmpl $2, -4(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.false
	cmpl $0, -8(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.false
	movl $1, -20(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -20(%rbp)
	Lmain.0.end:
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
