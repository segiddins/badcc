	.globl _incr_and_print
_incr_and_print:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $2, -16(%rbp)
	movl -16(%rbp), %edi
	call _putchar
	movl %eax, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
