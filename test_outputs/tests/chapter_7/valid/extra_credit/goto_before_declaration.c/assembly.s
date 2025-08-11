	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $0, -4(%rbp)
	cmpl $0, -4(%rbp)
	movl $0, -8(%rbp)
	setNE -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lmain.0.true
	Lreturn_a:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $4, -12(%rbp)
	jmp Lreturn_a
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
