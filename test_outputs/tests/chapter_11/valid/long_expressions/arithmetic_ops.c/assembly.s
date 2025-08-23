	.globl _a
	.bss
_a:
	.zero 8

	.globl _b
	.bss
_b:
	.zero 8

	.globl _addition
	.text
_addition:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _a(%rip), %r10
	movq %r10, -16(%rbp)
	movq _b(%rip), %r10
	addq %r10, -16(%rbp)
	movq $4294967295, %r10
	cmpq %r10, -16(%rbp)
	movq $0, -24(%rbp)
	setE -24(%rbp)
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
	.globl _subtraction
	.text
_subtraction:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq _a(%rip), %r10
	movq %r10, -16(%rbp)
	movq _b(%rip), %r10
	subq %r10, -16(%rbp)
	movq $4294967380, %r10
	movq %r10, -24(%rbp)
	negq -24(%rbp)
	movq -24(%rbp), %r10
	cmpq %r10, -16(%rbp)
	movq $0, -32(%rbp)
	setE -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _multiplication
	.text
_multiplication:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _a(%rip), %r10
	movq %r10, -16(%rbp)
	movq -16(%rbp), %r11
	imulq $4, %r11
	movq %r11, -16(%rbp)
	movq $17179869160, %r10
	cmpq %r10, -16(%rbp)
	movq $0, -24(%rbp)
	setE -24(%rbp)
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
	.globl _division
	.text
_division:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _a(%rip), %rax
	cqo
	movq $128, %r10
	idivq %r10
	movq %rax, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, _b(%rip)
	cmpq $33554431, _b(%rip)
	movq $0, -24(%rbp)
	setE -24(%rbp)
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
	.globl _remaind
	.text
_remaind:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq _a(%rip), %r10
	movq %r10, -16(%rbp)
	negq -16(%rbp)
	movq -16(%rbp), %rax
	cqo
	movq $4294967290, %r10
	idivq %r10
	movq %rdx, -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, _b(%rip)
	movq $5, -32(%rbp)
	negq -32(%rbp)
	movq -32(%rbp), %r10
	cmpq %r10, _b(%rip)
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
	.globl _complement
	.text
_complement:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq _a(%rip), %r10
	movq %r10, -16(%rbp)
	notq -16(%rbp)
	movq $9223372036854775807, %r10
	movq %r10, -24(%rbp)
	negq -24(%rbp)
	movq -24(%rbp), %r10
	cmpq %r10, -16(%rbp)
	movq $0, -32(%rbp)
	setE -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %eax
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
	subq $64, %rsp
	movq $4294967290, %r10
	movq %r10, _a(%rip)
	movq $5, _b(%rip)
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
	movq $4294967290, %r10
	movq %r10, -24(%rbp)
	negq -24(%rbp)
	movq -24(%rbp), %r10
	movq %r10, _a(%rip)
	movq $90, _b(%rip)
	call _subtraction
	movl %eax, -28(%rbp)
	cmpl $0, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $4294967290, %r10
	movq %r10, _a(%rip)
	call _multiplication
	movl %eax, -36(%rbp)
	cmpl $0, -36(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $4294967290, %r10
	movq %r10, _a(%rip)
	call _division
	movl %eax, -44(%rbp)
	cmpl $0, -44(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $8589934585, %r10
	movq %r10, _a(%rip)
	call _remaind
	movl %eax, -52(%rbp)
	cmpl $0, -52(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movq $9223372036854775806, %r10
	movq %r10, _a(%rip)
	call _complement
	movl %eax, -60(%rbp)
	cmpl $0, -60(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.5.true
	movl $6, %eax
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
