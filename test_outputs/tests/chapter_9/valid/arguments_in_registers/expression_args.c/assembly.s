	.globl _sub
	.text
_sub:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	subl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	addl $2, -12(%rbp)
	movl -12(%rbp), %edi
	movl $1, %esi
	call _sub
	movl %eax, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
