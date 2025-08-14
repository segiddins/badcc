	.globl _read_x
	.text
_read_x:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $4, -12(%rbp)
	cmpl $4, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lread_x.0.true
	movl _x(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lread_x.0.end
	Lread_x.0.true:
	movl $1, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lread_x.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
