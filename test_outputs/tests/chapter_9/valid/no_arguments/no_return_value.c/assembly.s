	.globl _foo
	.text
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, -12(%rbp)
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	call _foo
	movl %eax, -12(%rbp)
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
