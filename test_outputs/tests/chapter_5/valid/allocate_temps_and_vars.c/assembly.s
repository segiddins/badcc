	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $2147483646, -12(%rbp)
	movl $0, -16(%rbp)
	movl -12(%rbp), %eax
	cdq
	movl $6, %r10d
	idivl %r10d
	movl %eax, -20(%rbp)
	cmpl $0, -16(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -24(%rbp), %r10d
	addl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -36(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -40(%rbp)
	subl $1431655762, -40(%rbp)
	movl -40(%rbp), %r10d
	cmpl %r10d, -36(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
