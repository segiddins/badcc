	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $4, %r11d
	cmpl $0, %r11d
	jNE Lmain.0.true
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lmain.0.true
	movl $0, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $1, -12(%rbp)
	Lmain.0.end:
	movl $0, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $3, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $0, -16(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $1, -16(%rbp)
	Lmain.1.end:
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	movl $5, %r11d
	cmpl $0, %r11d
	jNE Lmain.2.true
	movl $5, %r11d
	cmpl $0, %r11d
	jNE Lmain.2.true
	movl $0, -24(%rbp)
	jmp Lmain.2.end
	Lmain.2.true:
	movl $1, -24(%rbp)
	Lmain.2.end:
	movl -20(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -24(%rbp), %r10d
	addl %r10d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
