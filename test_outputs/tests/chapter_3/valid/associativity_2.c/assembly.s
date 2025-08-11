	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $6, %eax
	cdq
	movl $3, %r10d
	idivl %r10d
	movl %eax, -4(%rbp)
	movl -4(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -8(%rbp)
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
