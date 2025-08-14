	.bss
_a.1:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, _a.1(%rip)
	movl _a.1(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl _a.1(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
