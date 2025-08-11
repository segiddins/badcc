	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $0, -4(%rbp)
	cmpl $0, -4(%rbp)
	jE Lmain.0.true
	movl $2, -8(%rbp)
	movl -8(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	movl $3, -12(%rbp)
	movl -12(%rbp), %r10d
	cmpl %r10d, -4(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.1.true
	cmpl $0, -4(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.1.end:
	Lmain.0.end:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
