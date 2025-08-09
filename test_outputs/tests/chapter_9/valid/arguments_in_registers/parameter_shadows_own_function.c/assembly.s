	.globl _a
_a:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl %edi, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -16(%rbp)
	movl -16(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, %edi
	call _a
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
