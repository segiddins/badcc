	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq $3, -16(%rbp)
	movq $4, -24(%rbp)
	movl $5, -28(%rbp)
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rsi
	movl -28(%rbp), %edx
	call _add_variables
	movq %rax, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
