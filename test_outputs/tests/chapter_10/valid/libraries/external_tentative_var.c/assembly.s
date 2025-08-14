	.globl _x
	.bss
_x:
	.zero 4
	.globl _read_x
	.text
_read_x:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _x(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
