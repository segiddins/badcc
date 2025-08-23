	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $144, %rsp
	movq $8589934592, %r10
	movq %r10, -16(%rbp)
	movl $1, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movq $8589934592, %r10
	movq %r10, -32(%rbp)
	negq -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -40(%rbp)
	movl $10, -44(%rbp)
	movq $8589934592, %r10
	cmpq %r10, -16(%rbp)
	movq $0, -52(%rbp)
	setNE -52(%rbp)
	cmpq $0, -52(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $1, -56(%rbp)
	negl -56(%rbp)
	movl -56(%rbp), %r10d
	cmpl %r10d, -24(%rbp)
	movl $0, -60(%rbp)
	setNE -60(%rbp)
	cmpl $0, -60(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $8589934592, %r10
	movq %r10, -68(%rbp)
	negq -68(%rbp)
	movq -68(%rbp), %r10
	cmpq %r10, -40(%rbp)
	movq $0, -76(%rbp)
	setNE -76(%rbp)
	cmpq $0, -76(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	cmpl $10, -44(%rbp)
	movl $0, -80(%rbp)
	setNE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq -16(%rbp), %r10
	movq %r10, -88(%rbp)
	negq -88(%rbp)
	movq -88(%rbp), %r10
	movq %r10, -16(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -92(%rbp)
	subl $1, -92(%rbp)
	movl -92(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movq -40(%rbp), %r10
	movq %r10, -100(%rbp)
	movq $8589934594, %r10
	addq %r10, -100(%rbp)
	movq -100(%rbp), %r10
	movq %r10, -40(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -104(%rbp)
	addl $10, -104(%rbp)
	movl -104(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movq $8589934592, %r10
	movq %r10, -112(%rbp)
	negq -112(%rbp)
	movq -112(%rbp), %r10
	cmpq %r10, -16(%rbp)
	movq $0, -120(%rbp)
	setNE -120(%rbp)
	cmpq $0, -120(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $2, -124(%rbp)
	negl -124(%rbp)
	movl -124(%rbp), %r10d
	cmpl %r10d, -24(%rbp)
	movl $0, -128(%rbp)
	setNE -128(%rbp)
	cmpl $0, -128(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	cmpq $2, -40(%rbp)
	movq $0, -136(%rbp)
	setNE -136(%rbp)
	cmpq $0, -136(%rbp)
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	cmpl $20, -44(%rbp)
	movl $0, -140(%rbp)
	setNE -140(%rbp)
	cmpl $0, -140(%rbp)
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
