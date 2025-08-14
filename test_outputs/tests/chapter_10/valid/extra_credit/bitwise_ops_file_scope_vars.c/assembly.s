	.globl _x
	.data
_x:
	.long 1
	.globl _y
	.bss
_y:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, _y(%rip)
	movl _x(%rip), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r11d
	sall $1, %r11d
	movl %r11d, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	orl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, _x(%rip)
	cmpl $3, _x(%rip)
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
	movl $5, -28(%rbp)
	negl -28(%rbp)
	movl _y(%rip), %r10d
	movl %r10d, -32(%rbp)
	movl -28(%rbp), %r10d
	andl %r10d, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	xorl $12, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %r11d
	sarl $2, %r11d
	movl %r11d, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, _y(%rip)
	movl $3, -44(%rbp)
	negl -44(%rbp)
	movl -44(%rbp), %r10d
	cmpl %r10d, _y(%rip)
	movl $0, -48(%rbp)
	setNE -48(%rbp)
	cmpl $0, -48(%rbp)
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
