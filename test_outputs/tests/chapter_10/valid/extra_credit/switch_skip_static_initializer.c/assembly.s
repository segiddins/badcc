	.globl _a
	.data
_a:
	.long 3
	.data
_x.2:
	.long 10
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp Lswitch.0.cases
	Lswitch.0.1:
	movl $0, _x.2(%rip)
	Lswitch.0.3:
	movl _x.2(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $1, %r11d
	cmpl _a(%rip), %r11d
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lswitch.0.1
	movl $3, %r11d
	cmpl _a(%rip), %r11d
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lswitch.0.3
	Lswitch.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
