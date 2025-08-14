	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $12, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %eax
	cdq
	movl $5, %r10d
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
