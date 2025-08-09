	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $80, -12(%rbp)
	movl -12(%rbp), %r11d
	sarl $2, %r11d
	movl %r11d, -12(%rbp)
	movl $7, -16(%rbp)
	movl -16(%rbp), %r11d
	sall $1, %r11d
	movl %r11d, -16(%rbp)
	movl $5, -20(%rbp)
	movl -16(%rbp), %r10d
	andl %r10d, -20(%rbp)
	movl $1, -24(%rbp)
	movl -20(%rbp), %r10d
	xorl %r10d, -24(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -24(%rbp), %r10d
	orl %r10d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
