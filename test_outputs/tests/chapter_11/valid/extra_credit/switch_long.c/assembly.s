	.globl _switch_on_long
	.text
_switch_on_long:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, -16(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.100:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.8589934592:
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.default:
	movl $1, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movq $0, %r11
	cmpq -16(%rbp), %r11
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.0
	movq $100, %r11
	cmpq -16(%rbp), %r11
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.100
	movq $8589934592, %r11
	cmpq -16(%rbp), %r11
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.8589934592
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
	subq $32, %rsp
	movq $8589934592, %rdi
	call _switch_on_long
	movl %eax, -12(%rbp)
	cmpl $2, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $100, %rdi
	call _switch_on_long
	movl %eax, -20(%rbp)
	cmpl $1, -20(%rbp)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
