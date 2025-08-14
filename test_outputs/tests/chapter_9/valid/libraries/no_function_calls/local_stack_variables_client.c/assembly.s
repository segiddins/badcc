	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl $2, -16(%rbp)
	negl -16(%rbp)
	movl $3, -20(%rbp)
	negl -20(%rbp)
	subq $8, %rsp
	movl $1, %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $5, %r8d
	movl $6, %r9d
	movl -20(%rbp), %eax
	pushq %rax
	movl -16(%rbp), %eax
	pushq %rax
	movl -12(%rbp), %eax
	pushq %rax
	call _f
	addq $32, %rsp
	movl %eax, -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
