	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $3, %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	imull $4, %r11d
	movl %r11d, -16(%rbp)
	movl $5, -20(%rbp)
	subl $4, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $3, -24(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -24(%rbp), %r10d
	addl %r10d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
