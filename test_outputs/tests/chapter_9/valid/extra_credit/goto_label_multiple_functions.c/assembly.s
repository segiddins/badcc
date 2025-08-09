	.globl _foo
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp Lfoo.label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lfoo.label:
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp Lmain.label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.label:
	call _foo
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
