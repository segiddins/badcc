	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $0, -12(%rbp)
	jmp Lmain.label
	Lloop.0.start:
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lloop.0
	Lmain.label:
	movl $1, -12(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
