	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	movl $0, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl $3, -20(%rbp)
	movl -20(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
