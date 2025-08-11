	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $5, -4(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.default:
	movl $0, -4(%rbp)
	Lswitch.0.1:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	jmp Lswitch.0.default
	movl $1, %r11d
	cmpl $0, %r11d
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jNE Lswitch.0.1
	Lswitch.0:
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
