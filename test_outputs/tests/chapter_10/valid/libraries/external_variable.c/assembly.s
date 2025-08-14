	.globl _x
	.data
_x:
	.long 3
	.globl _update_x
	.text
_update_x:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl %edi, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, _x(%rip)
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _read_x
	.text
_read_x:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _x(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
