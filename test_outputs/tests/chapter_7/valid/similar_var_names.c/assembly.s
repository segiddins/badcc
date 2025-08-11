	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $72, %rsp
	movl $1, -12(%rbp)
	movl $2, -16(%rbp)
	movl $2, -20(%rbp)
	movl $20, -56(%rbp)
	movl -56(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl $5, -60(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -60(%rbp), %r10d
	addl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -68(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -68(%rbp)
	movl -68(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -72(%rbp)
	movl -12(%rbp), %r10d
	addl %r10d, -72(%rbp)
	movl -72(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
