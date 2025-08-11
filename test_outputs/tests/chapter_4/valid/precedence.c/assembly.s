	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $1, %r11d
	cmpl $0, %r11d
	jNE Lmain.0.true
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.1.false
	movl $2, %r11d
	cmpl $0, %r11d
	jE Lmain.1.false
	movl $1, -8(%rbp)
	jmp Lmain.1.end
	Lmain.1.false:
	movl $0, -8(%rbp)
	Lmain.1.end:
	cmpl $0, -8(%rbp)
	jNE Lmain.0.true
	movl $0, -4(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $1, -4(%rbp)
	Lmain.0.end:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
