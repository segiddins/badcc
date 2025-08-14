	.globl _sum
	.text
_sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
