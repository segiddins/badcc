	.globl _negative_one
	.data
_negative_one:
	.quad 1
	.globl _zero
	.bss
_zero:
	.zero 8

	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq _negative_one(%rip), %r10
	movq %r10, -16(%rbp)
	negq -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, _negative_one(%rip)
	movq _negative_one(%rip), %r10
	movq %r10, -24(%rbp)
	movq $68719476736, %r11
	cmpq -24(%rbp), %r11
	movq $0, -32(%rbp)
	setAE -32(%rbp)
	cmpq $0, -32(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $2147483658, %r10
	movq %r10, -40(%rbp)
	negq -40(%rbp)
	movq _zero(%rip), %r10
	cmpq %r10, -40(%rbp)
	movq $0, -48(%rbp)
	setGE -48(%rbp)
	cmpq $0, -48(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $3, -56(%rbp)
	movq $4294967293, %r10
	addq %r10, -56(%rbp)
	cmpq $0, -56(%rbp)
	movq $0, -64(%rbp)
	setE -64(%rbp)
	cmpq $0, -64(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
