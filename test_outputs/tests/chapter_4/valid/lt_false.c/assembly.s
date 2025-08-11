	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	movl $2, %r11d
	cmpl $1, %r11d
	movl $0, -4(%rbp)
	setL -4(%rbp)
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
