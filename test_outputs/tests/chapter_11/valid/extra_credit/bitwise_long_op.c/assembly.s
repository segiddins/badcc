	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $304, %rsp
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
	movq $71777214277877760, %r10
	cmpq %r10, -40(%rbp)
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
	movq -16(%rbp), %r10
	movq %r10, -56(%rbp)
	movq -32(%rbp), %r10
	orq %r10, -56(%rbp)
	movq $4278255361, %r10
	movq %r10, -64(%rbp)
	negq -64(%rbp)
	movq -64(%rbp), %r10
	cmpq %r10, -56(%rbp)
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
	movq -16(%rbp), %r10
	movq %r10, -80(%rbp)
	movq -32(%rbp), %r10
	xorq %r10, -80(%rbp)
	movq $71777218556133121, %r10
	movq %r10, -88(%rbp)
	negq -88(%rbp)
	movq -88(%rbp), %r10
	cmpq %r10, -80(%rbp)
	movq $0, -96(%rbp)
	setNE -96(%rbp)
	cmpq $0, -96(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $1, -104(%rbp)
	negq -104(%rbp)
	movq -104(%rbp), %r10
	movq %r10, -112(%rbp)
	movq $34359738368, %r10
	andq %r10, -112(%rbp)
	movq $34359738368, %r10
	cmpq %r10, -112(%rbp)
	movq $0, -120(%rbp)
	setNE -120(%rbp)
	cmpq $0, -120(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $0, -128(%rbp)
	movq $34359738368, %r10
	orq %r10, -128(%rbp)
	movq $34359738368, %r10
	cmpq %r10, -128(%rbp)
	movq $0, -136(%rbp)
	setNE -136(%rbp)
	cmpq $0, -136(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movq $34359738368, %r10
	movq %r10, -144(%rbp)
	movq $137438953472, %r10
	xorq %r10, -144(%rbp)
	movq $171798691840, %r10
	cmpq %r10, -144(%rbp)
	movq $0, -152(%rbp)
	setNE -152(%rbp)
	cmpq $0, -152(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movq $4611686018427387903, %r10
	movq %r10, -160(%rbp)
	movl $1073741824, -164(%rbp)
	negl -164(%rbp)
	movl -164(%rbp), %r10d
	movl %r10d, -168(%rbp)
	movl $1, -172(%rbp)
	negl -172(%rbp)
	movl -172(%rbp), %r10d
	movl %r10d, -176(%rbp)
	movl -168(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -184(%rbp)
	movq -184(%rbp), %r10
	movq %r10, -192(%rbp)
	movq -160(%rbp), %r10
	andq %r10, -192(%rbp)
	movq $4611686017353646080, %r10
	cmpq %r10, -192(%rbp)
	movq $0, -200(%rbp)
	setNE -200(%rbp)
	cmpq $0, -200(%rbp)
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movl -168(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -208(%rbp)
	movq -160(%rbp), %r10
	movq %r10, -216(%rbp)
	movq -208(%rbp), %r10
	orq %r10, -216(%rbp)
	movl $1, -220(%rbp)
	negl -220(%rbp)
	movl -220(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -228(%rbp)
	movq -228(%rbp), %r10
	cmpq %r10, -216(%rbp)
	movq $0, -236(%rbp)
	setNE -236(%rbp)
	cmpq $0, -236(%rbp)
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movl -168(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -244(%rbp)
	movq -160(%rbp), %r10
	movq %r10, -252(%rbp)
	movq -244(%rbp), %r10
	xorq %r10, -252(%rbp)
	movq $4611686017353646081, %r10
	movq %r10, -260(%rbp)
	negq -260(%rbp)
	movq -260(%rbp), %r10
	cmpq %r10, -252(%rbp)
	movq $0, -268(%rbp)
	setNE -268(%rbp)
	cmpq $0, -268(%rbp)
	jE Lmain.8.true
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.8.end
	Lmain.8.true:
	Lmain.8.end:
	movl -176(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -276(%rbp)
	movq -276(%rbp), %r10
	movq %r10, -284(%rbp)
	movq $4611686018427387903, %r10
	xorq %r10, -284(%rbp)
	movq $4611686018427387903, %r10
	movq %r10, -292(%rbp)
	notq -292(%rbp)
	movq -292(%rbp), %r10
	cmpq %r10, -284(%rbp)
	movq $0, -300(%rbp)
	setNE -300(%rbp)
	cmpq $0, -300(%rbp)
	jE Lmain.9.true
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.9.end
	Lmain.9.true:
	Lmain.9.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
