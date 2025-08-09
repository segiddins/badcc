	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	movl $2, %r11d
	cmpl $0, %r11d
	jE Lmain.1.true
	movl $3, -12(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $4, -12(%rbp)
	Lmain.1.end:
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $5, -16(%rbp)
	Lmain.0.end:
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.2.true
	movl $2, %r11d
	cmpl $0, %r11d
	jE Lmain.3.true
	movl $3, -24(%rbp)
	jmp Lmain.3.end
	Lmain.3.true:
	movl $4, -24(%rbp)
	Lmain.3.end:
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	jmp Lmain.2.end
	Lmain.2.true:
	movl $5, -28(%rbp)
	Lmain.2.end:
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r11d
	imull -32(%rbp), %r11d
	movl %r11d, -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
