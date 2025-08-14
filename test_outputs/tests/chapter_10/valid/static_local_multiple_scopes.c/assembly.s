	.data
_i.3:
	.long 65
	.data
_i.4:
	.long 97
	.globl _print_letters
	.text
_print_letters:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _i.3(%rip), %edi
	call _putchar
	movl %eax, -12(%rbp)
	movl _i.3(%rip), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, _i.3(%rip)
	movl _i.4(%rip), %edi
	call _putchar
	movl %eax, -20(%rbp)
	movl _i.4(%rip), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, _i.4(%rip)
	movl $10, %edi
	call _putchar
	movl %eax, -28(%rbp)
	movl $0, %eax
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
	cmpl $26, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	call _print_letters
	movl %eax, -20(%rbp)
	Lloop.0.start:
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
