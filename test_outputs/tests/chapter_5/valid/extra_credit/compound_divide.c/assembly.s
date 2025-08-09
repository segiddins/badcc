	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $8, -12(%rbp)
	movl -12(%rbp), %eax
	cdq
	movl $4, %r10d
	idivl %r10d
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
