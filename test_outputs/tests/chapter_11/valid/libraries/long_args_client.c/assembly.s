	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	subq $8, %rsp
	movl $0, %edi
	movl $0, %esi
	movl $0, %edx
	movq $34359738368, %rcx
	movl $0, %r8d
	movq $34359738368, %r9
	movq $34359738368, %rax
	pushq %rax
	pushq $0
	pushq $0
	call _test_sum
	addq $32, %rsp
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
