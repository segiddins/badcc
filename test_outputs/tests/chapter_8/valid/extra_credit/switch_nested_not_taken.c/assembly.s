	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $0, -4(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.1:
	jmp Lswitch.1.cases
	Lswitch.1.0:
	movl $0, %eax
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
	movl $0, %r11d
	cmpl -4(%rbp), %r11d
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lswitch.1.0
	jmp Lswitch.1.default
	Lswitch.1:
	Lswitch.0.default:
	movl $2, -4(%rbp)
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $1, %r11d
	cmpl -4(%rbp), %r11d
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jNE Lswitch.0.1
	jmp Lswitch.0.default
	Lswitch.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
