	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $3, -12(%rbp)
	movl $4, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setG -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.true
	call _foo
	movl %eax, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -32(%rbp)
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _foo
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
