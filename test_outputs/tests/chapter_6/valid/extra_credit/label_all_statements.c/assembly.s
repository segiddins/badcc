	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, -12(%rbp)
	Lmain.label_if:
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	jmp Lmain.label_expression
	jmp Lmain.0.end
	Lmain.0.true:
	jmp Lmain.label_empty
	Lmain.0.end:
	Lmain.label_goto:
	jmp Lmain.label_return
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.1.true
	Lmain.label_expression:
	movl $0, -12(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	jmp Lmain.label_if
	Lmain.label_return:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.label_empty:
	movl $100, -12(%rbp)
	jmp Lmain.label_goto
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
