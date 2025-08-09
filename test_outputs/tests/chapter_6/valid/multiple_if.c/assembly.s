	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $2, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $3, -12(%rbp)
	Lmain.0.end:
	cmpl $0, -16(%rbp)
	jE Lmain.1.true
	movl $4, -16(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $5, -16(%rbp)
	Lmain.1.end:
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
