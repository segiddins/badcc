	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $400, -12(%rbp)
	Lloop.0.cond:
	cmpl $100, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	subl $100, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
