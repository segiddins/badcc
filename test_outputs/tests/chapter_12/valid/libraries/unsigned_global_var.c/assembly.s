	.globl _ui
	.data
_ui:
	.long 4294967200
	.globl _return_uint
	.text
_return_uint:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _ui(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _return_uint_as_signed
	.text
_return_uint_as_signed:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _ui(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _return_uint_as_long
	.text
_return_uint_as_long:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _ui(%rip), %r11d
	movq %r11, -16(%rbp)
	movq -16(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
