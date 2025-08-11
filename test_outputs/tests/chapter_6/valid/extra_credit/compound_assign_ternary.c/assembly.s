	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl $4, -4(%rbp)
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	movl $2, -8(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $3, -8(%rbp)
	Lmain.0.end:
	movl -4(%rbp), %r10d
	movl %r10d, -4(%rbp)
	movl -4(%rbp), %r11d
	imull -8(%rbp), %r11d
	movl %r11d, -4(%rbp)
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
