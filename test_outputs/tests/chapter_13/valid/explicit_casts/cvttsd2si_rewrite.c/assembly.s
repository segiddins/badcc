	.globl _glob
	.data
_glob:
	.quad 0x4008000000000000
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movq $1, -16(%rbp)
	negq -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movl $1, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	cvttsd2sil _glob(%rip), %r11d
	movl %r11d, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl $20, -44(%rbp)
	movq $1, -52(%rbp)
	negq -52(%rbp)
	movq -52(%rbp), %r10
	cmpq %r10, -24(%rbp)
	movq $0, -60(%rbp)
	setNE -60(%rbp)
	cmpq $0, -60(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $1, -64(%rbp)
	negl -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -32(%rbp)
	movl $0, -68(%rbp)
	setNE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	cmpl $3, -40(%rbp)
	movl $0, -72(%rbp)
	setNE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	cmpl $20, -44(%rbp)
	movl $0, -76(%rbp)
	setNE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
