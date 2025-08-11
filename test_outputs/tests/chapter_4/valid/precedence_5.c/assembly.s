	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $0, %r11d
	cmpl $0, %r11d
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lmain.0.false
	movl $2, -12(%rbp)
	addl $1, -12(%rbp)
	cmpl $1, -12(%rbp)
	movl $0, -16(%rbp)
	setG -16(%rbp)
	movl $3, %r11d
	cmpl -16(%rbp), %r11d
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.false
	movl $1, -4(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -4(%rbp)
	Lmain.0.end:
	movl -4(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
