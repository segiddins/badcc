	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $3, -12(%rbp)
	movl $0, -16(%rbp)
	jmp Lswitch.0.cases
	movl $5, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	Lswitch.0.3:
	movl $4, -20(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $3, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jNE Lswitch.0.3
	Lswitch.0:
	cmpl $3, -12(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.false
	cmpl $4, -16(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.0.false
	movl $1, -40(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -40(%rbp)
	Lmain.0.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
