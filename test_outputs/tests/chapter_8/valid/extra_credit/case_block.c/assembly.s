	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $4, -12(%rbp)
	movl $0, -16(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.2:
	movl $8, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $2, %r11d
	cmpl $2, %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.2
	Lswitch.0:
	cmpl $4, -12(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.false
	cmpl $8, -16(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.0.false
	movl $1, -36(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -36(%rbp)
	Lmain.0.end:
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
