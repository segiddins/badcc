	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $0, -12(%rbp)
	movl $1, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	cmpl $1, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.1.true
	movl $3, -12(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $4, -12(%rbp)
	Lmain.1.end:
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
