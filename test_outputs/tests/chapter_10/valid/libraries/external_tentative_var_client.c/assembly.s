	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	cmpl $0, _x(%rip)
	movl $0, -12(%rbp)
	setNE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $3, _x(%rip)
	call _read_x
	movl %eax, -16(%rbp)
	cmpl $3, -16(%rbp)
	movl $0, -20(%rbp)
	setNE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.1.true
	movl $1, %eax
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
