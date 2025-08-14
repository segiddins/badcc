	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $5, -12(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.5:
	movl $10, -12(%rbp)
	jmp Lswitch.0
	Lswitch.0.6:
	movl $0, -12(%rbp)
	jmp Lswitch.0
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $5, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.5
	movl $6, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.6
	Lswitch.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
