	.globl _switch_statement
	.text
_switch_statement:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl %edi, -12(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.default:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.0
	movl $0, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.0
	jmp Lswitch.0.default
	Lswitch.0:
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
	movl $0, %edi
	call _switch_statement
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
