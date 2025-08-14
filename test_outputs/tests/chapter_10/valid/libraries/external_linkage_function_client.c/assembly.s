	.globl _add_one_and_two
	.text
_add_one_and_two:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl $1, %edi
	movl $2, %esi
	call _sum
	movl %eax, -12(%rbp)
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _add_three_and_four
	.text
_add_three_and_four:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $3, -12(%rbp)
	cmpl $2, -12(%rbp)
	movl $0, -16(%rbp)
	setG -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Ladd_three_and_four.0.true
	movl $3, %edi
	movl $4, %esi
	call _sum
	movl %eax, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Ladd_three_and_four.0.end
	Ladd_three_and_four.0.true:
	Ladd_three_and_four.0.end:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	call _add_three_and_four
	movl %eax, -12(%rbp)
	cmpl $7, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	call _add_one_and_two
	movl %eax, -20(%rbp)
	cmpl $3, -20(%rbp)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
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
