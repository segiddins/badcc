	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $1, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $1, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	addl $1, -4(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $-1, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $-1, -8(%rbp)
	cmpl $3, -4(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.false
	movl $2, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %r10d
	cmpl %r10d, -8(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
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
