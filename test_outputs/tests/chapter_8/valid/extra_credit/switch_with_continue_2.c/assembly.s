	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $28, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	Lloop.0.cond:
	cmpl $10, -8(%rbp)
	movl $0, -12(%rbp)
	setL -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lloop.0
	movl -8(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -16(%rbp)
	jmp Lswitch.1.cases
	Lswitch.1.0:
	jmp Lloop.0.start
	Lswitch.1.default:
	movl -4(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lswitch.1
	Lswitch.1.cases:
	movl $0, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.1.0
	jmp Lswitch.1.default
	Lswitch.1:
	Lloop.0.start:
	movl -8(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
