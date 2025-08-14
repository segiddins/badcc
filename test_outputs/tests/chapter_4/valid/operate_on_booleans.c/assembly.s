	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, %r11d
	cmpl $0, %r11d
	jE Lmain.0.false
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.false
	movl $1, -12(%rbp)
	jmp Lmain.0.end
	Lmain.0.false:
	movl $0, -12(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	notl -16(%rbp)
	movl $4, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $3, %r11d
	cmpl $0, %r11d
	jNE Lmain.1.true
	movl $0, -20(%rbp)
	jmp Lmain.1.end
	Lmain.1.true:
	movl $1, -20(%rbp)
	Lmain.1.end:
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	negl -24(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -24(%rbp), %r10d
	subl %r10d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
