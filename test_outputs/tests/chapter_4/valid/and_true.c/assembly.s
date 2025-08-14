	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.false
	movl $1, -12(%rbp)
	negl -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.false
	movl $1, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -16(%rbp)
	Lmain.0.end:
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
