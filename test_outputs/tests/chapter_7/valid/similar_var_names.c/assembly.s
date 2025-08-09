	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $1, -12(%rbp)
	movl $2, -16(%rbp)
	movl $2, -20(%rbp)
	movl $20, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl $5, -32(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -32(%rbp), %r10d
	addl %r10d, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -12(%rbp), %r10d
	addl %r10d, -44(%rbp)
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
