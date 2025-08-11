	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $0, -4(%rbp)
	jmp Ldo_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Ldo_label:
	Lloop.0.head:
	movl $1, -4(%rbp)
	jmp Lwhile_label
	Lloop.0.start:
	movl $1, %r11d
	cmpl $0, %r11d
	jNE Lloop.0.head
	Lloop.0:
	Lwhile_label:
	Lloop.1.start:
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lloop.1
	movl -4(%rbp), %r10d
	movl %r10d, -8(%rbp)
	addl $1, -8(%rbp)
	movl -8(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lbreak_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lbreak_label:
	jmp Lloop.1
	jmp Lloop.1.start
	Lloop.1:
	jmp Lfor_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lfor_label:
	movl $0, -12(%rbp)
	Lloop.2.cond:
	cmpl $10, -12(%rbp)
	movl $0, -16(%rbp)
	setL -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lloop.2
	movl -4(%rbp), %r10d
	movl %r10d, -20(%rbp)
	addl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lcontinue_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lcontinue_label:
	jmp Lloop.2.start
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lloop.2.start:
	movl -12(%rbp), %r10d
	movl %r10d, -24(%rbp)
	addl $1, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lloop.2.cond
	Lloop.2:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
