	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $10, -12(%rbp)
	cmpl $0, -12(%rbp)
	jNE Lmain.1.true
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $0, -16(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $1, -16(%rbp)
	Lmain.1.end:
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $20, -20(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $0, -20(%rbp)
	Lmain.0.end:
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
