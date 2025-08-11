	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $12, %rsp
	movl $400, -4(%rbp)
	Lloop.0.cond:
	cmpl $100, -4(%rbp)
	movl $0, -8(%rbp)
	setE -8(%rbp)
	cmpl $0, -8(%rbp)
	jE Lmain.0.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.0.start:
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	subl $100, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
