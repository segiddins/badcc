	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $4, -4(%rbp)
	movl $9, -8(%rbp)
	movl $0, -12(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	movl -8(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $7, -16(%rbp)
	Lmain.0.end:
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.7:
	movl $1, -12(%rbp)
	Lswitch.0.9:
	movl $2, -12(%rbp)
	Lswitch.0.1:
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $4, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.0.0
	movl $7, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.0.7
	movl $9, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.0.9
	movl $1, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lswitch.0.1
	Lswitch.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
