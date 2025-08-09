	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $10, -12(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.1:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.10:
	movl $0, -16(%rbp)
	Lloop.1.cond:
	cmpl $5, -16(%rbp)
	movl $0, -20(%rbp)
	setL -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.1
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	subl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $8, -12(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.true
	jmp Lloop.1
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.1.start:
	movl -16(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -16(%rbp)
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
	cmpl -12(%rbp), %r11d
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jNE Lswitch.0.1
	movl $10, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
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
