	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $3, %r11d
	cmpl $1, %r11d
	movl $0, -4(%rbp)
	setE -4(%rbp)
	cmpl $2, -4(%rbp)
	movl $0, -8(%rbp)
	setNE -8(%rbp)
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
