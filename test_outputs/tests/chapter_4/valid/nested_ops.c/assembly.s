	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $3, -4(%rbp)
	negl -4(%rbp)
	cmpl $0, -4(%rbp)
	movl $0, -8(%rbp)
	setE -8(%rbp)
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
