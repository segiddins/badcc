	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	jmp L_main
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	L_main:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
