	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $2593, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %eax
	cdq
	movl $3, %r10d
	idivl %r10d
	movl %edx, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	negl -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
