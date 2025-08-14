	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $10, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	subl $1, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl -12(%rbp), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $0, -16(%rbp)
	Lmain.0.end:
	cmpl $4, -12(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
