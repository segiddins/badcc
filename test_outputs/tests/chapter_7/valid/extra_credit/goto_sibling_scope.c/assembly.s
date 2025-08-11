	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $20, %rsp
	movl $0, -4(%rbp)
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	movl $5, -8(%rbp)
	jmp Lother_if
	movl $0, -4(%rbp)
	Lfirst_if:
	movl $5, -8(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -8(%rbp), %r10d
	addl %r10d, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.1.true
	Lother_if:
	movl $6, -16(%rbp)
	movl -4(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -4(%rbp)
	jmp Lfirst_if
	movl $0, -4(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl -4(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
