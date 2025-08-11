	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $1, -4(%rbp)
	Lloop.0.head:
	Lwhile_start:
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $1, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -4(%rbp)
	cmpl $10, -4(%rbp)
	movl $0, -12(%rbp)
	setL -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	jmp Lwhile_start
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.0.start:
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lloop.0.head
	Lloop.0:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
