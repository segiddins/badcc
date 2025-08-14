	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	jmp Lmain.do_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.do_label:
	Lloop.0.head:
	movl $1, -12(%rbp)
	jmp Lmain.while_label
	Lloop.0.start:
	movl $1, %r11d
	cmpl $0, %r11d
	jNE Lloop.0.head
	Lloop.0:
	Lmain.while_label:
	Lloop.1.start:
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lloop.1
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	addl $1, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lmain.break_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.break_label:
	jmp Lloop.1
	jmp Lloop.1.start
	Lloop.1:
	jmp Lmain.for_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.for_label:
	movl $0, -20(%rbp)
	Lloop.2.cond:
	cmpl $10, -20(%rbp)
	movl $0, -24(%rbp)
	setL -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lloop.2
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lmain.continue_label
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lmain.continue_label:
	jmp Lloop.2.start
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lloop.2.start:
	movl -20(%rbp), %r10d
	movl %r10d, -32(%rbp)
	addl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -20(%rbp)
	jmp Lloop.2.cond
	Lloop.2:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
