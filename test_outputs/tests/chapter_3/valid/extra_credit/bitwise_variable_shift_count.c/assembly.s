	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $2, -12(%rbp)
	movl -12(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -12(%rbp)
	movl $4, -16(%rbp)
	movl -16(%rbp), %r11d
	movl -12(%rbp), %ecx
	sall %cl, %r11d
	movl %r11d, -16(%rbp)
	movl $1, -20(%rbp)
	addl $2, -20(%rbp)
	movl $100, -24(%rbp)
	movl -24(%rbp), %r11d
	movl -20(%rbp), %ecx
	sarl %cl, %r11d
	movl %r11d, -24(%rbp)
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
