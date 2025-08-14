	.bss
_b.2:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $2, -12(%rbp)
	movl $4, -16(%rbp)
	negl -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl $7, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, _b.2(%rip)
	cmpl $8, _b.2(%rip)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.false
	movl $4, -32(%rbp)
	negl -32(%rbp)
	movl -32(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.0.false
	movl $1, -40(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -40(%rbp)
	Lmain.0.end:
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
