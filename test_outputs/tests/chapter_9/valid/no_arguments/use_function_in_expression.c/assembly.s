	.globl _bar
_bar:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _foo
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	call _bar
	movl %eax, -12(%rbp)
	movl $2, -16(%rbp)
	movl -16(%rbp), %r11d
	imull -12(%rbp), %r11d
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
	subq $32, %rsp
	call _foo
	movl %eax, -12(%rbp)
	call _bar
	movl %eax, -16(%rbp)
	movl -16(%rbp), %eax
	cdq
	movl $3, %r10d
	idivl %r10d
	movl %eax, -20(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
