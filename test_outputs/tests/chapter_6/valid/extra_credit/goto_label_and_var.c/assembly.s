	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $5, -12(%rbp)
	jmp Lmain.ident
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.ident:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
