	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.cond:
	cmpl $10, -16(%rbp)
	movl $0, -20(%rbp)
	setL -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	movl -16(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -24(%rbp)
	jmp Lswitch.1.cases
	Lswitch.1.0:
	jmp Lloop.0.start
	Lswitch.1.default:
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lswitch.1
	Lswitch.1.cases:
	movl $0, %r11d
	cmpl -24(%rbp), %r11d
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jNE Lswitch.1.0
	jmp Lswitch.1.default
	Lswitch.1:
	Lloop.0.start:
	movl -16(%rbp), %r10d
	movl %r10d, -36(%rbp)
	addl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
