	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	movl $3, %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %edx, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $4, -8(%rbp)
	Lmain.0.end:
	movl -8(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
