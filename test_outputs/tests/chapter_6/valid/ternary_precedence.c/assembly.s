	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $10, -4(%rbp)
	cmpl $0, -4(%rbp)
	jNE Lmain.1.true
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $0, -12(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $1, -12(%rbp)
	Lmain.1.end:
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $20, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $0, -8(%rbp)
	Lmain.0.end:
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
