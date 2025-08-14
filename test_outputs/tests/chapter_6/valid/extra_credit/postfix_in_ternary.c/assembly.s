	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $10, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	subl $10, -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $0, -20(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $-1, -12(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -20(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
