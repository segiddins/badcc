	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	cmpl $2, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $2, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $0, -20(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
