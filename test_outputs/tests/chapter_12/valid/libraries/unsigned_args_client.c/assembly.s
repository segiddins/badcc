	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl $1, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -28(%rbp)
	subq $8, %rsp
	movl $1, %edi
	movl -16(%rbp), %esi
	movq -28(%rbp), %rdx
	movq $-9223372036854775808, %rcx
	movl $2147483648, %r8d
	movl $0, %r9d
	movq $-9223372032559808512, %rax
	pushq %rax
	movl $2147487744, %eax
	pushq %rax
	pushq $123456
	call _accept_unsigned
	addq $32, %rsp
	movl %eax, -32(%rbp)
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
