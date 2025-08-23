	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $96, %rsp
	movq $9223372036854775807, %r10
	movq %r10, -16(%rbp)
	negq -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -32(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -24(%rbp)
	addq $1, -24(%rbp)
	movq $9223372036854775807, %r10
	movq %r10, -40(%rbp)
	negq -40(%rbp)
	movq -40(%rbp), %r10
	cmpq %r10, -32(%rbp)
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
	movq $9223372036854775806, %r10
	movq %r10, -56(%rbp)
	negq -56(%rbp)
	movq -56(%rbp), %r10
	cmpq %r10, -24(%rbp)
	movq $0, -64(%rbp)
	setNE -64(%rbp)
	cmpq $0, -64(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq -24(%rbp), %r10
	movq %r10, -24(%rbp)
	addq $-1, -24(%rbp)
	movq $9223372036854775807, %r10
	movq %r10, -72(%rbp)
	negq -72(%rbp)
	movq -72(%rbp), %r10
	cmpq %r10, -24(%rbp)
	movq $0, -80(%rbp)
	setNE -80(%rbp)
	cmpq $0, -80(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $9223372036854775807, %r10
	movq %r10, -88(%rbp)
	negq -88(%rbp)
	movq -88(%rbp), %r10
	cmpq %r10, -24(%rbp)
	movq $0, -96(%rbp)
	setNE -96(%rbp)
	cmpq $0, -96(%rbp)
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
