	.globl _ui_a
	.bss
_ui_a:
	.zero 4

	.globl _ui_b
	.bss
_ui_b:
	.zero 4

	.globl _ul_a
	.bss
_ul_a:
	.zero 8

	.globl _ul_b
	.bss
_ul_b:
	.zero 8

	.globl _addition
	.text
_addition:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _ui_a(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl _ui_b(%rip), %r10d
	addl %r10d, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
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
	subq $32, %rsp
	movq _ul_a(%rip), %r10
	movq %r10, -16(%rbp)
	movq _ul_b(%rip), %r10
	subq %r10, -16(%rbp)
	cmpq $-10, -16(%rbp)
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
	.globl _neg
	.text
_neg:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _ul_a(%rip), %r10
	movq %r10, -16(%rbp)
	negq -16(%rbp)
	cmpq $-1, -16(%rbp)
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
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $4294967293, %r10d
	movl %r10d, _ui_a(%rip)
	movl $3, _ui_b(%rip)
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
	movq $10, _ul_a(%rip)
	movq $20, _ul_b(%rip)
	call _subtraction
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
	movq $1, _ul_a(%rip)
	call _neg
	movl %eax, -28(%rbp)
	cmpl $0, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
