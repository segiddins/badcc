	.globl _x
	.bss
_x:
	.zero 4

	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $10, -12(%rbp)
	jmp Lmain.x
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.x:
	movl _x(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
