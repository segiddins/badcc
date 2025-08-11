	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $28, %rsp
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
	movl %r10d, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $5, -8(%rbp)
	Lmain.0.end:
	movl -8(%rbp), %r10d
	movl %r10d, -4(%rbp)
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
	movl %r10d, -20(%rbp)
	jmp Lmain.2.end
	Lmain.2.true:
	movl $5, -20(%rbp)
	Lmain.2.end:
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
