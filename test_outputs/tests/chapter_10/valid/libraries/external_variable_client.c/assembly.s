	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	cmpl $3, _x(%rip)
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
	movl $4, _x(%rip)
	cmpl $4, _x(%rip)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.2.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	call _read_x
	movl %eax, -28(%rbp)
	cmpl $4, -28(%rbp)
	movl $0, -32(%rbp)
	setNE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.3.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $5, %edi
	call _update_x
	movl %eax, -36(%rbp)
	cmpl $5, _x(%rip)
	movl $0, -40(%rbp)
	setNE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.4.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	call _read_x
	movl %eax, -44(%rbp)
	cmpl $5, -44(%rbp)
	movl $0, -48(%rbp)
	setNE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.5.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
