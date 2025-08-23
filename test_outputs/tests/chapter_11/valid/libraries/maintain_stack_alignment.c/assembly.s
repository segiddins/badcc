	.globl _add_variables
	.text
_add_variables:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
	movl %edx, -28(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -36(%rbp)
	movq -24(%rbp), %r10
	addq %r10, -36(%rbp)
	movl -28(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -44(%rbp)
	movq -36(%rbp), %r10
	movq %r10, -52(%rbp)
	movq -44(%rbp), %r10
	addq %r10, -52(%rbp)
	movq -52(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
