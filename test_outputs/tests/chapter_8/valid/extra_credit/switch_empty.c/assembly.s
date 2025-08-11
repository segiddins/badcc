	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $10, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $1, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lswitch.0.cases
	jmp Lswitch.0
	Lswitch.0.cases:
	Lswitch.0:
	movl -4(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lswitch.1.cases
	jmp Lswitch.1
	Lswitch.1.cases:
	Lswitch.1:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
