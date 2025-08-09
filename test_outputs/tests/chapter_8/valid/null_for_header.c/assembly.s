	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	Lloop.0.cond:
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	cmpl $3, -12(%rbp)
	movl $0, -20(%rbp)
	setG -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	jmp Lloop.0
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.0.start:
	jmp Lloop.0.cond
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
