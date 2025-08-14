	.bss
_i.2:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $12345, -12(%rbp)
	movl $5, _i.2(%rip)
	Lloop.0.cond:
	cmpl $0, _i.2(%rip)
	movl $0, -16(%rbp)
	setGE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.0
	movl -12(%rbp), %eax
	cdq
	movl $3, %r10d
	idivl %r10d
	movl %eax, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	movl _i.2(%rip), %r10d
	movl %r10d, -24(%rbp)
	subl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, _i.2(%rip)
	jmp Lloop.0.cond
	Lloop.0:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
