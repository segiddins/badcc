	.bss
_i.7:
	.zero 4
	.globl _call_static_my_fun
	.text
_call_static_my_fun:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	call _my_fun
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _call_static_my_fun_2
	.text
_call_static_my_fun_2:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	call _my_fun
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.text
_my_fun:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _i.7(%rip), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, _i.7(%rip)
	movl _i.7(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
