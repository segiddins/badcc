	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $144, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movq $-9223372036854775808, %r10
	movq %r10, -24(%rbp)
	movl -16(%rbp), %r11d
	movq %r11, -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -40(%rbp)
	movq -24(%rbp), %r10
	andq %r10, -40(%rbp)
	cmpq $0, -40(%rbp)
	movq $0, -48(%rbp)
	setNE -48(%rbp)
	cmpq $0, -48(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -16(%rbp), %r11d
	movq %r11, -56(%rbp)
	movq -56(%rbp), %r10
	movq %r10, -64(%rbp)
	movq -24(%rbp), %r10
	orq %r10, -64(%rbp)
	movq $-9223372032559808513, %r10
	cmpq %r10, -64(%rbp)
	movq $0, -72(%rbp)
	setNE -72(%rbp)
	cmpq $0, -72(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $1, -76(%rbp)
	negl -76(%rbp)
	movl -76(%rbp), %r10d
	movl %r10d, -80(%rbp)
	movl -80(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -88(%rbp)
	movq -88(%rbp), %r10
	movq %r10, -96(%rbp)
	movq -24(%rbp), %r10
	andq %r10, -96(%rbp)
	movq -24(%rbp), %r10
	cmpq %r10, -96(%rbp)
	movq $0, -104(%rbp)
	setNE -104(%rbp)
	cmpq $0, -104(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl -80(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -112(%rbp)
	movq -112(%rbp), %r10
	movq %r10, -120(%rbp)
	movq -24(%rbp), %r10
	orq %r10, -120(%rbp)
	movl -80(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -128(%rbp)
	movq -128(%rbp), %r10
	cmpq %r10, -120(%rbp)
	movq $0, -136(%rbp)
	setNE -136(%rbp)
	cmpq $0, -136(%rbp)
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
