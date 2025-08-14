	.bss
_var0.1:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $2, _var0.1(%rip)
	movl _var0.1(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
