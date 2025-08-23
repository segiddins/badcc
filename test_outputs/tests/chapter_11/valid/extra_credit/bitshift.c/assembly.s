	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $160, %rsp
	movq $137438953472, %r10
	movq %r10, -16(%rbp)
	movl $2, -20(%rbp)
	movl -20(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -28(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -36(%rbp)
	movq -36(%rbp), %r11
	movl -28(%rbp), %ecx
	sarq %cl, %r11
	movq %r11, -36(%rbp)
	movq $34359738368, %r10
	cmpq %r10, -36(%rbp)
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
	movl -20(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -52(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -60(%rbp)
	movq -60(%rbp), %r11
	movl -52(%rbp), %ecx
	salq %cl, %r11
	movq %r11, -60(%rbp)
	movq $549755813888, %r10
	cmpq %r10, -60(%rbp)
	movq $0, -68(%rbp)
	setNE -68(%rbp)
	cmpq $0, -68(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq -16(%rbp), %r10
	movq %r10, -76(%rbp)
	movq -76(%rbp), %r11
	salq $2, %r11
	movq %r11, -76(%rbp)
	movq $549755813888, %r10
	cmpq %r10, -76(%rbp)
	movq $0, -84(%rbp)
	setNE -84(%rbp)
	cmpq $0, -84(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $40, -92(%rbp)
	movq -92(%rbp), %r11
	salq $40, %r11
	movq %r11, -92(%rbp)
	movq $43980465111040, %r10
	cmpq %r10, -92(%rbp)
	movq $0, -100(%rbp)
	setNE -100(%rbp)
	cmpq $0, -100(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $3, -108(%rbp)
	movl $0, -112(%rbp)
	movl $2147483645, -116(%rbp)
	negl -116(%rbp)
	movl -116(%rbp), %r10d
	movl %r10d, -120(%rbp)
	movl $0, -124(%rbp)
	movl -108(%rbp), %r10d
	movl %r10d, -128(%rbp)
	movl -120(%rbp), %r10d
	movl %r10d, -132(%rbp)
	movl -132(%rbp), %r11d
	movl -128(%rbp), %ecx
	sarl %cl, %r11d
	movl %r11d, -132(%rbp)
	movl $268435456, -136(%rbp)
	negl -136(%rbp)
	movl -136(%rbp), %r10d
	cmpl %r10d, -132(%rbp)
	movl $0, -140(%rbp)
	setNE -140(%rbp)
	cmpl $0, -140(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $1, -144(%rbp)
	negl -144(%rbp)
	movl -144(%rbp), %r10d
	movl %r10d, -120(%rbp)
	movl -120(%rbp), %r10d
	movl %r10d, -148(%rbp)
	movl -148(%rbp), %r11d
	sarl $10, %r11d
	movl %r11d, -148(%rbp)
	movl $1, -152(%rbp)
	negl -152(%rbp)
	movl -152(%rbp), %r10d
	cmpl %r10d, -148(%rbp)
	movl $0, -156(%rbp)
	setNE -156(%rbp)
	cmpl $0, -156(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	cmpl $0, -112(%rbp)
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	cmpl $0, -124(%rbp)
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
