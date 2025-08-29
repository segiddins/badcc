	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $2, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	sarl $3, %r11d
	movl %r11d, -16(%rbp)
	movl $1, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r10d
	cmpl %r10d, -16(%rbp)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $-1, -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -32(%rbp)
	movq -32(%rbp), %r11
	shlq $44, %r11
	movq %r11, -32(%rbp)
	movq $-17592186044416, %r10
	cmpq %r10, -32(%rbp)
	movq $0, -40(%rbp)
	setNE -40(%rbp)
	cmpq $0, -40(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
