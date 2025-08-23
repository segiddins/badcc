	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $100, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	sall $2, %r11d
	movl %r11d, -16(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.400:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.400:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $400, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.0.400
	movl $400, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.0.400
	Lswitch.0:
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
