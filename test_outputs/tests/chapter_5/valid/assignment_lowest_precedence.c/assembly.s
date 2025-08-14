	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lmain.0.true
	movl $5, %r11d
	cmpl $0, %r11d
	jNE Lmain.0.true
	movl $0, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $1, -12(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
