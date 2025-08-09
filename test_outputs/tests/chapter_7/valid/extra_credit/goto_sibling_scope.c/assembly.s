	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	movl $5, -16(%rbp)
	jmp Lmain.other_if
	movl $0, -12(%rbp)
	Lmain.first_if:
	movl $5, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.1.true
	Lmain.other_if:
	movl $6, -24(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -24(%rbp), %r10d
	addl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -12(%rbp)
	jmp Lmain.first_if
	movl $0, -12(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
