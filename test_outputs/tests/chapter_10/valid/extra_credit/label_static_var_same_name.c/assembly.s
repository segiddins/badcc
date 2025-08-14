	.data
_x.1:
	.long 5
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp Lmain.x
	movl $0, _x.1(%rip)
	Lmain.x:
	movl _x.1(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
