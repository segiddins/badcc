	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl $1, -16(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $1, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	notl -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.1.true
	movl $2, -16(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	Lmain.0.end:
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
