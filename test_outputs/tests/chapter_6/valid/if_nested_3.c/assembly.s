	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $0, -4(%rbp)
	movl $1, -4(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	cmpl $1, -4(%rbp)
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lmain.1.true
	movl $3, -4(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $4, -4(%rbp)
	Lmain.1.end:
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
