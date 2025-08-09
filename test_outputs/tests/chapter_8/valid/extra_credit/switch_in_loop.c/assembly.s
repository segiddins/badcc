	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	movl $0, -20(%rbp)
	Lloop.0.cond:
	cmpl $10, -20(%rbp)
	movl $0, -24(%rbp)
	setL -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lloop.0
	jmp Lswitch.1.cases
	Lswitch.1.0:
	movl $2, -12(%rbp)
	jmp Lswitch.1
	Lswitch.1.1:
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r11d
	imull $3, %r11d
	movl %r11d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lswitch.1
	Lswitch.1.2:
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -32(%rbp), %r11d
	imull $4, %r11d
	movl %r11d, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lswitch.1
	Lswitch.1.default:
	movl -12(%rbp), %r10d
	movl %r10d, -36(%rbp)
	addl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lswitch.1
	Lswitch.1.cases:
	movl $0, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jNE Lswitch.1.0
	movl $1, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jNE Lswitch.1.1
	movl $2, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jNE Lswitch.1.2
	jmp Lswitch.1.default
	Lswitch.1:
	movl -16(%rbp), %r10d
	movl %r10d, -44(%rbp)
	addl $1, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lloop.0.start:
	movl -20(%rbp), %r10d
	movl %r10d, -48(%rbp)
	addl $1, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $10, -16(%rbp)
	movl $0, -52(%rbp)
	setE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.0.false
	cmpl $31, -12(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.0.false
	movl $1, -60(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -60(%rbp)
	Lmain.0.end:
	movl -60(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
