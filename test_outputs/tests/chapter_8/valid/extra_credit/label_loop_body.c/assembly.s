	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	movl $0, -4(%rbp)
	jmp Llabel
	Lloop.0.start:
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lloop.0
	Llabel:
	movl $1, -4(%rbp)
	jmp Lloop.0.start
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
