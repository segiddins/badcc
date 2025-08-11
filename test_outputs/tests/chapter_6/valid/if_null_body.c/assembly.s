	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp
	movl $0, -4(%rbp)
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
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
