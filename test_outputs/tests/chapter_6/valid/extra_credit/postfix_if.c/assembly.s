	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $-1, -12(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $-1, -12(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.1.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	Lmain.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
