	.globl _a
	.text
_a:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _b
	.text
_b:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl %edi, -12(%rbp)
	movl -12(%rbp), %eax
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
	call _a
	movl %eax, -12(%rbp)
	movl $2, %edi
	call _b
	movl %eax, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
