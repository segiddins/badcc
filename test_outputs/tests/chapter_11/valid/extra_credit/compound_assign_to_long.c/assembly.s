	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq $34359738368, %r10
	movq %r10, -16(%rbp)
	negq -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movl $10, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -32(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -40(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -48(%rbp)
	movq -40(%rbp), %r10
	subq %r10, -48(%rbp)
	movq -48(%rbp), %r10
	movq %r10, -24(%rbp)
	movq $34359738358, %r10
	movq %r10, -56(%rbp)
	negq -56(%rbp)
	movq -56(%rbp), %r10
	cmpq %r10, -24(%rbp)
	movq $0, -64(%rbp)
	setNE -64(%rbp)
	cmpq $0, -64(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
