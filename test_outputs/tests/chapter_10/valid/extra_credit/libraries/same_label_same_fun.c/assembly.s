	.text
_f:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp Lf.x
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lf.x:
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _f_caller
	.text
_f_caller:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	call _f
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
