	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	movl $0, -16(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $0, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	Lmain.0.end:
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
