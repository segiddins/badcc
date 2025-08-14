	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.3:
	jmp Lswitch.1.cases
	Lswitch.1.3:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.1.4:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.1.default:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.1
	Lswitch.1.cases:
	movl $3, %r11d
	cmpl $4, %r11d
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lswitch.1.3
	movl $4, %r11d
	cmpl $4, %r11d
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lswitch.1.4
	jmp Lswitch.1.default
	Lswitch.1:
	Lswitch.0.4:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.default:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl $3, %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.0
	movl $3, %r11d
	cmpl $3, %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.3
	movl $4, %r11d
	cmpl $3, %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.4
	jmp Lswitch.0.default
	Lswitch.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
