	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $28, %rsp
	movl $10, -4(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.1:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.10:
	movl $0, -12(%rbp)
	Lloop.1.cond:
	cmpl $5, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.1
	movl -4(%rbp), %r10d
	movl %r10d, -20(%rbp)
	subl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -4(%rbp)
	cmpl $8, -4(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.true
	jmp Lloop.1
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.1.start:
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.1.cond
	Lloop.1:
	movl $123, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.default:
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $1, %r11d
	cmpl -4(%rbp), %r11d
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jNE Lswitch.0.1
	movl $10, %r11d
	cmpl -4(%rbp), %r11d
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jNE Lswitch.0.10
	jmp Lswitch.0.default
	Lswitch.0:
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
