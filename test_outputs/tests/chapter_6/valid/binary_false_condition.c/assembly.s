	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $1, -4(%rbp)
	addl $2, -4(%rbp)
	cmpl $4, -4(%rbp)
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lmain.0.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
