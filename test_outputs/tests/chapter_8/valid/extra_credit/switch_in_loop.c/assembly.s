	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $52, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	movl $0, -12(%rbp)
	Lloop.0.cond:
	cmpl $10, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	jmp Lswitch.1.cases
	Lswitch.1.0:
	movl $2, -4(%rbp)
	jmp Lswitch.1
	Lswitch.1.1:
	movl -4(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -24(%rbp), %r11d
	imull $3, %r11d
	movl %r11d, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lswitch.1
	Lswitch.1.2:
	movl -4(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r11d
	imull $4, %r11d
	movl %r11d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lswitch.1
	Lswitch.1.default:
	movl -4(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lswitch.1
	Lswitch.1.cases:
	movl $0, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.1.0
	movl $1, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.1.1
	movl $2, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.1.2
	jmp Lswitch.1.default
	Lswitch.1:
	movl -8(%rbp), %r10d
	movl %r10d, -36(%rbp)
	addl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -8(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -40(%rbp)
	addl $1, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $10, -8(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.0.false
	cmpl $31, -4(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.0.false
	movl $1, -44(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -44(%rbp)
	Lmain.0.end:
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
