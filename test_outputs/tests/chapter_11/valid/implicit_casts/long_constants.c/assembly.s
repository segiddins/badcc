	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $2147483647, -16(%rbp)
	addq $2147483647, -16(%rbp)
	cmpq $0, -16(%rbp)
	movq $0, -24(%rbp)
	setL -24(%rbp)
	cmpq $0, -24(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $19327352832, %r11
	cmpq $100, %r11
	movq $0, -32(%rbp)
	setL -32(%rbp)
	cmpq $0, -32(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
