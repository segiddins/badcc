	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $28, %rsp
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.4:
	movl $0, -8(%rbp)
	movl $0, -12(%rbp)
	Lloop.1.cond:
	cmpl $10, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.1
	movl -12(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	jmp Lloop.1.start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -8(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -8(%rbp)
	Lloop.1.start:
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.1.cond
	Lloop.1:
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl $4, %r11d
	movl $0, -4(%rbp)
	setE -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lswitch.0.0
	movl $4, %r11d
	cmpl $4, %r11d
	movl $0, -4(%rbp)
	setE -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lswitch.0.4
	Lswitch.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
