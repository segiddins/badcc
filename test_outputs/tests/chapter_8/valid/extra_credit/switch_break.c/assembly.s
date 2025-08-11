	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $5, -4(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.5:
	movl $10, -4(%rbp)
	jmp Lswitch.0
	Lswitch.0.6:
	movl $0, -4(%rbp)
	jmp Lswitch.0
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $5, %r11d
	cmpl -4(%rbp), %r11d
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jNE Lswitch.0.5
	movl $6, %r11d
	cmpl -4(%rbp), %r11d
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jNE Lswitch.0.6
	Lswitch.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
