	.globl _i
	.bss
_i:
	.zero 4

	.globl _l
	.bss
_l:
	.zero 8

	.globl _addition
	.text
_addition:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl _i(%rip), %r11d
	movslq %r11d, %r10
	movq %r10, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movq _l(%rip), %r10
	addq %r10, -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -32(%rbp)
	movq $2147483663, %r10
	cmpq %r10, -32(%rbp)
	movq $0, -40(%rbp)
	setE -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _division
	.text
_division:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl _i(%rip), %r11d
	movslq %r11d, %r10
	movq %r10, -16(%rbp)
	movq _l(%rip), %rax
	cqo
	idivq -16(%rbp)
	movq %rax, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	cmpl $214748364, -32(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _comparison
	.text
_comparison:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _i(%rip), %r11d
	movslq %r11d, %r10
	movq %r10, -16(%rbp)
	movq _l(%rip), %r10
	cmpq %r10, -16(%rbp)
	movq $0, -24(%rbp)
	setLE -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -28(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _conditional
	.text
_conditional:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $1, %r11d
	cmpl $0, %r11d
	jE Lconditional.0.true
	movq _l(%rip), %r10
	movq %r10, -16(%rbp)
	jmp Lconditional.0.end
	Lconditional.0.true:
	movl _i(%rip), %r11d
	movslq %r11d, %r10
	movq %r10, -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -16(%rbp)
	Lconditional.0.end:
	movq -16(%rbp), %r10
	movq %r10, -32(%rbp)
	movq $8589934592, %r10
	cmpq %r10, -32(%rbp)
	movq $0, -40(%rbp)
	setE -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -44(%rbp), %eax
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
	subq $48, %rsp
	movq $2147483653, %r10
	movq %r10, _l(%rip)
	movl $10, _i(%rip)
	call _addition
	movl %eax, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $2147483649, %r10
	movq %r10, _l(%rip)
	call _division
	movl %eax, -20(%rbp)
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $100, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, _i(%rip)
	movq $2147483648, %r10
	movq %r10, _l(%rip)
	call _comparison
	movl %eax, -32(%rbp)
	cmpl $0, -32(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $8589934592, %r10
	movq %r10, _l(%rip)
	movl $10, _i(%rip)
	call _conditional
	movl %eax, -40(%rbp)
	cmpl $0, -40(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
