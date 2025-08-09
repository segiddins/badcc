	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $7, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.default:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.2:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	jmp Lswitch.0.default
	movl $2, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.2
	Lswitch.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
