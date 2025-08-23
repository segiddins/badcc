	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq $9223372036854775807, %r10
	movq %r10, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	subq $2, -24(%rbp)
	movq $9223372036854775805, %r10
	cmpq %r10, -24(%rbp)
	movq $0, -32(%rbp)
	setE -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
