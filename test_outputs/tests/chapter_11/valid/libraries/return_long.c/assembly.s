	.globl _add
	.text
_add:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -24(%rbp)
	movl -16(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -32(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -40(%rbp)
	movq -32(%rbp), %r10
	addq %r10, -40(%rbp)
	movq -40(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
