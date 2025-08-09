	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $10, -12(%rbp)
	Lloop.0.head:
	jmp Lloop.0
	Lloop.0.start:
	movl $1, -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
