	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	movl $10, -4(%rbp)
	Lloop.0.head:
	jmp Lloop.0
	Lloop.0.start:
	movl $1, -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lloop.0.head
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
