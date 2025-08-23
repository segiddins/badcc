	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $192, %rsp
	movq $71777214294589695, %r10
	movq %r10, -16(%rbp)
	movq $4294967296, %r10
	movq %r10, -24(%rbp)
	negq -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -32(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -40(%rbp)
	movq -32(%rbp), %r10
	andq %r10, -40(%rbp)
	movq -40(%rbp), %r10
	movq %r10, -16(%rbp)
	movq $71777214277877760, %r10
	cmpq %r10, -16(%rbp)
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
	movq -32(%rbp), %r10
	movq %r10, -56(%rbp)
	orq $100, -56(%rbp)
	movq -56(%rbp), %r10
	movq %r10, -32(%rbp)
	movq $4294967196, %r10
	movq %r10, -64(%rbp)
	negq -64(%rbp)
	movq -64(%rbp), %r10
	cmpq %r10, -32(%rbp)
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
	movq $9223372036854775807, %r10
	movq %r10, -80(%rbp)
	negq -80(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -88(%rbp)
	movq -80(%rbp), %r10
	xorq %r10, -88(%rbp)
	movq -88(%rbp), %r10
	movq %r10, -16(%rbp)
	movq $9151594822576898047, %r10
	movq %r10, -96(%rbp)
	negq -96(%rbp)
	movq -96(%rbp), %r10
	cmpq %r10, -16(%rbp)
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
	movq $4611686018427387903, %r10
	movq %r10, -16(%rbp)
	movl $1073741824, -108(%rbp)
	negl -108(%rbp)
	movl -108(%rbp), %r10d
	movl %r10d, -112(%rbp)
	movl -112(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -120(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -128(%rbp)
	movq -120(%rbp), %r10
	andq %r10, -128(%rbp)
	movq -128(%rbp), %r10
	movq %r10, -16(%rbp)
	movq $4611686017353646080, %r10
	cmpq %r10, -16(%rbp)
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
	movq $2147483648, %r10
	movq %r10, -144(%rbp)
	negq -144(%rbp)
	movl -144(%rbp), %r10d
	movl %r10d, -148(%rbp)
	movl -148(%rbp), %r10d
	movl %r10d, -112(%rbp)
	movl -112(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -156(%rbp)
	movq -156(%rbp), %r10
	movq %r10, -164(%rbp)
	movq $71777214294589695, %r10
	orq %r10, -164(%rbp)
	movl -164(%rbp), %r10d
	movl %r10d, -168(%rbp)
	movl -168(%rbp), %r10d
	movl %r10d, -112(%rbp)
	movl $2130771713, -172(%rbp)
	negl -172(%rbp)
	movl -172(%rbp), %r10d
	cmpl %r10d, -112(%rbp)
	movl $0, -176(%rbp)
	setNE -176(%rbp)
	cmpl $0, -176(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $2130771713, -180(%rbp)
	negl -180(%rbp)
	movl -180(%rbp), %r10d
	cmpl %r10d, -112(%rbp)
	movl $0, -184(%rbp)
	setNE -184(%rbp)
	cmpl $0, -184(%rbp)
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
