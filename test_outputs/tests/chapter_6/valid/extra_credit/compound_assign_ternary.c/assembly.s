	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $4, -12(%rbp)
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lmain.0.true
	movl $2, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	movl $3, -16(%rbp)
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
