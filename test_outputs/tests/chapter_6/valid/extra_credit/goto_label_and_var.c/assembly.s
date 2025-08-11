	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	movl $5, -4(%rbp)
	jmp Lident
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lident:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
