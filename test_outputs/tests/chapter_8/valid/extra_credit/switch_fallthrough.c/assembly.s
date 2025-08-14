	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $4, -12(%rbp)
	movl $9, -16(%rbp)
	movl $0, -20(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $7, -24(%rbp)
	Lmain.0.end:
	jmp Lswitch.0.cases
	Lswitch.0.0:
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.7:
	movl $1, -20(%rbp)
	Lswitch.0.9:
	movl $2, -20(%rbp)
	Lswitch.0.1:
	movl -20(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $4, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl -24(%rbp), %r11d
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jNE Lswitch.0.0
	movl $7, %r11d
	cmpl -24(%rbp), %r11d
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jNE Lswitch.0.7
	movl $9, %r11d
	cmpl -24(%rbp), %r11d
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jNE Lswitch.0.9
	movl $1, %r11d
	cmpl -24(%rbp), %r11d
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jNE Lswitch.0.1
	Lswitch.0:
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
