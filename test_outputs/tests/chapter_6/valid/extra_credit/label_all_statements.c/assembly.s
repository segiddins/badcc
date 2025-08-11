	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	movl $1, -4(%rbp)
	Llabel_if:
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	jmp Llabel_expression
	jmp Lmain.0.end
	Lmain.0.true:
	jmp Llabel_empty
	Lmain.0.end:
	Llabel_goto:
	jmp Llabel_return
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.1.true
	Llabel_expression:
	movl $0, -4(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	jmp Llabel_if
	Llabel_return:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Llabel_empty:
	movl $100, -4(%rbp)
	jmp Llabel_goto
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
