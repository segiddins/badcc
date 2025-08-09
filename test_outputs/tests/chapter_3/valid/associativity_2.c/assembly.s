	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $6, %eax
	cdq
	movl $3, %r10d
	idivl %r10d
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
