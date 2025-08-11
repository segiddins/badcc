	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $37, -4(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	addl $4, -12(%rbp)
	movl -12(%rbp), %eax
	cdq
	movl $5, %r10d
	idivl %r10d
	movl %eax, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -8(%rbp)
	movl -4(%rbp), %eax
	cdq
	movl $5, %r10d
	idivl %r10d
	movl %edx, -20(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.0:
	Lloop.1.head:
	movl -4(%rbp), %r10d
	movl %r10d, -28(%rbp)
	subl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lswitch.0.4:
	movl -4(%rbp), %r10d
	movl %r10d, -32(%rbp)
	subl $1, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lswitch.0.3:
	movl -4(%rbp), %r10d
	movl %r10d, -36(%rbp)
	subl $1, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lswitch.0.2:
	movl -4(%rbp), %r10d
	movl %r10d, -40(%rbp)
	subl $1, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lswitch.0.1:
	movl -4(%rbp), %r10d
	movl %r10d, -44(%rbp)
	subl $1, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -4(%rbp)
	Lloop.1.start:
	movl -8(%rbp), %r10d
	movl %r10d, -48(%rbp)
	subl $1, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -8(%rbp)
	cmpl $0, -8(%rbp)
	movl $0, -52(%rbp)
	setG -52(%rbp)
	cmpl $0, -52(%rbp)
	jNE Lloop.1.head
	Lloop.1:
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $0, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.0
	movl $4, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.4
	movl $3, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.3
	movl $2, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.2
	movl $1, %r11d
	cmpl -20(%rbp), %r11d
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jNE Lswitch.0.1
	Lswitch.0:
	cmpl $0, -4(%rbp)
	movl $0, -60(%rbp)
	setE -60(%rbp)
	cmpl $0, -60(%rbp)
	jE Lmain.0.false
	cmpl $0, -8(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.0.false
	movl $1, -56(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -56(%rbp)
	Lmain.0.end:
	movl -56(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
