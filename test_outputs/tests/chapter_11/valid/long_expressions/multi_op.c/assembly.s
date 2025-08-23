	.globl _target
	.text
_target:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq %rdi, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movq -24(%rbp), %r11
	imulq $5, %r11
	movq %r11, -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -32(%rbp)
	subq $10, -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -40(%rbp)
	movq $21474836440, %r10
	cmpq %r10, -40(%rbp)
	movq $0, -48(%rbp)
	setE -48(%rbp)
	cmpq $0, -48(%rbp)
	jE Ltarget.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Ltarget.0.end
	Ltarget.0.true:
	Ltarget.0.end:
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
	subq $16, %rsp
	movq $4294967290, %rdi
	call _target
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
