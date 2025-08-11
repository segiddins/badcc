	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
