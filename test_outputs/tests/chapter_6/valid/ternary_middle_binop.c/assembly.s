	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	movl $3, %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $4, -16(%rbp)
	Lmain.0.end:
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
