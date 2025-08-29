	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $144, %rsp
	movq $-283686952306184, %r10
	movq %r10, -16(%rbp)
	movl $1000, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -28(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -36(%rbp)
	movq -28(%rbp), %r10
	andq %r10, -36(%rbp)
	movq -36(%rbp), %r10
	movq %r10, -16(%rbp)
	movq $-283686952306664, %r10
	cmpq %r10, -16(%rbp)
	movq $0, -44(%rbp)
	setNE -44(%rbp)
	cmpq $0, -44(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq -16(%rbp), %r10
	movq %r10, -52(%rbp)
	movq $4294967040, %r10
	orq %r10, -52(%rbp)
	movq -52(%rbp), %r10
	movq %r10, -16(%rbp)
	movq $-283686884868328, %r10
	cmpq %r10, -16(%rbp)
	movq $0, -60(%rbp)
	setNE -60(%rbp)
	cmpq $0, -60(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $123456, -64(%rbp)
	movl $4042322160, %r10d
	movl %r10d, -68(%rbp)
	movl $252645136, -72(%rbp)
	negl -72(%rbp)
	movl -72(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -80(%rbp)
	movq -80(%rbp), %r10
	movq %r10, -88(%rbp)
	movl -68(%rbp), %r11d
	movq %r11, -96(%rbp)
	movq -96(%rbp), %r10
	movq %r10, -104(%rbp)
	movq -88(%rbp), %r10
	xorq %r10, -104(%rbp)
	movl -104(%rbp), %r10d
	movl %r10d, -108(%rbp)
	movl -108(%rbp), %r10d
	movl %r10d, -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	cmpl $0, -68(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	cmpl $123456, -64(%rbp)
	movl $0, -112(%rbp)
	setNE -112(%rbp)
	cmpl $0, -112(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $252645136, -116(%rbp)
	negl -116(%rbp)
	movl -116(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -124(%rbp)
	movq -124(%rbp), %r10
	cmpq %r10, -88(%rbp)
	movq $0, -132(%rbp)
	setNE -132(%rbp)
	cmpq $0, -132(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
