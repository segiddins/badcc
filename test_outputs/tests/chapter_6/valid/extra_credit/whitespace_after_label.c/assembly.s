	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp Lmain.label2
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.label1:
	Lmain.label2:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
