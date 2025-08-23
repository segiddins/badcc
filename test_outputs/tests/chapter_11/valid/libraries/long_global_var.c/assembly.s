	.globl _l
	.data
_l:
	.quad 8589934592
	.globl _return_l
	.text
_return_l:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq _l(%rip), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _return_l_as_int
	.text
_return_l_as_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _l(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
