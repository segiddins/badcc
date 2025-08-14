	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $0, -12(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.1:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.2:
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.4:
	movl $11, -12(%rbp)
	jmp Lswitch.0
	Lswitch.0.default:
	movl $22, -12(%rbp)
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $1, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.1
	movl $2, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.2
	movl $4, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.4
	jmp Lswitch.0.default
	Lswitch.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
