	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $0, -12(%rbp)
	Lloop.0.start:
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lloop.0
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $10, -12(%rbp)
	movl $0, -20(%rbp)
	setG -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	jmp Lloop.0
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	jmp Lloop.0.start
	Lloop.0:
	movl $10, -24(%rbp)
	Lloop.1.start:
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lloop.1
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	subl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -24(%rbp)
	cmpl $0, -24(%rbp)
	movl $0, -32(%rbp)
	setL -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.1.true
	jmp Lloop.1
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	jmp Lloop.1.start
	Lloop.1:
	movl $1, -36(%rbp)
	negl -36(%rbp)
	movl -36(%rbp), %r10d
	cmpl %r10d, -24(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.2.false
	cmpl $11, -12(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.2.false
	movl $1, -48(%rbp)
	jmp Lmain.2.end
	Lmain.2.false:
	movl $0, -48(%rbp)
	Lmain.2.end:
	movl -48(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movl -52(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
