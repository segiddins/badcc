	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $3, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	andl $6, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
