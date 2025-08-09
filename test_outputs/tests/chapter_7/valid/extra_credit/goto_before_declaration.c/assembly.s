	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	Lmain.return_a:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $4, -20(%rbp)
	jmp Lmain.return_a
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
