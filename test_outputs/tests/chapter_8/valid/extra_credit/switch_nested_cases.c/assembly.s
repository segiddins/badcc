	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $44, %rsp
	movl $0, -4(%rbp)
	movl $0, -8(%rbp)
	movl $0, -12(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.1:
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	Lswitch.0.3:
	movl $1, -4(%rbp)
	jmp Lswitch.0
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lswitch.0.default:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl $3, %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.0
	movl $1, %r11d
	cmpl $3, %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.1
	movl $3, %r11d
	cmpl $3, %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.3
	jmp Lswitch.0.default
	Lswitch.0:
	jmp Lswitch.1.cases
	Lswitch.1.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.1.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lswitch.1.4:
	movl $1, -8(%rbp)
	jmp Lswitch.1
	Lmain.1.end:
	Lswitch.1.default:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.1
	Lswitch.1.cases:
	movl $0, %r11d
	cmpl $4, %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.1.0
	movl $4, %r11d
	cmpl $4, %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.1.4
	jmp Lswitch.1.default
	Lswitch.1:
	jmp Lswitch.2.cases
	movl $0, -28(%rbp)
	Lloop.3.cond:
	cmpl $10, -28(%rbp)
	movl $0, -32(%rbp)
	setL -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lloop.3
	movl $0, -4(%rbp)
	Lswitch.2.5:
	movl $1, -12(%rbp)
	jmp Lloop.3
	Lswitch.2.default:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lloop.3.start:
	movl -28(%rbp), %r10d
	movl %r10d, -36(%rbp)
	addl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -28(%rbp)
	jmp Lloop.3.cond
	Lloop.3:
	jmp Lswitch.2
	Lswitch.2.cases:
	movl $5, %r11d
	cmpl $5, %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.2.5
	jmp Lswitch.2.default
	Lswitch.2:
	cmpl $0, -4(%rbp)
	jE Lmain.2.false
	cmpl $0, -8(%rbp)
	jE Lmain.2.false
	movl $1, -44(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -44(%rbp)
	Lmain.2.end:
	cmpl $0, -44(%rbp)
	jE Lmain.3.false
	cmpl $0, -12(%rbp)
	jE Lmain.3.false
	movl $1, -40(%rbp)
	jmp Lmain.3.end
	Lmain.3.false:
	movl $0, -40(%rbp)
	Lmain.3.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
