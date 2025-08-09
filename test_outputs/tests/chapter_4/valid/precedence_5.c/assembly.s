	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, %r11d
	cmpl $0, %r11d
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.false
	movl $2, -16(%rbp)
	addl $1, -16(%rbp)
	cmpl $1, -16(%rbp)
	movl $0, -20(%rbp)
	setG -20(%rbp)
	movl $3, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.false
	movl $1, -28(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -28(%rbp)
	Lmain.0.end:
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
