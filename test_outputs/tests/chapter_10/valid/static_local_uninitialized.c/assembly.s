	.bss
_x.1:
	.zero 4

	.globl _foo
	.text
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _x.1(%rip), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, _x.1(%rip)
	movl _x.1(%rip), %eax
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
	movl $0, -12(%rbp)
	Lloop.0.cond:
	cmpl $4, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	call _foo
	movl %eax, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
