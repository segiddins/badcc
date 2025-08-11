	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.1:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.3:
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.5:
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl $3, %r11d
	movl $0, -4(%rbp)
	setE -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lswitch.0.0
	movl $1, %r11d
	cmpl $3, %r11d
	movl $0, -4(%rbp)
	setE -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lswitch.0.1
	movl $3, %r11d
	cmpl $3, %r11d
	movl $0, -4(%rbp)
	setE -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lswitch.0.3
	movl $5, %r11d
	cmpl $3, %r11d
	movl $0, -4(%rbp)
	setE -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lswitch.0.5
	Lswitch.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
