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
	movl $2147483653, %r10d
	addl %r10d, -12(%rbp)
	movl $2147483663, %r10d
	cmpl %r10d, -12(%rbp)
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
	cmpq $-1073742824, -16(%rbp)
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
	.globl _multiplication
	.text
_multiplication:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _ui_a(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r11d
	imull _ui_b(%rip), %r11d
	movl %r11d, -12(%rbp)
	movl $3221225472, %r10d
	cmpl %r10d, -12(%rbp)
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
	.globl _division
	.text
_division:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _ui_a(%rip), %eax
	movl $0, %edx
	divl _ui_b(%rip)
	movl %eax, -12(%rbp)
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
	.globl _division_large_dividend
	.text
_division_large_dividend:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _ui_a(%rip), %eax
	movl $0, %edx
	divl _ui_b(%rip)
	movl %eax, -12(%rbp)
	cmpl $2, -12(%rbp)
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
	.globl _division_by_literal
	.text
_division_by_literal:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _ul_a(%rip), %rax
	movq $0, %rdx
	movq $5, %r10
	divq %r10
	movq %rax, -16(%rbp)
	movq $219902325555, %r10
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
	.globl _remaind
	.text
_remaind:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _ul_b(%rip), %rax
	movq $0, %rdx
	divq _ul_a(%rip)
	movq %rdx, -16(%rbp)
	cmpq $5, -16(%rbp)
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
	.globl _complement
	.text
_complement:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _ui_a(%rip), %r10d
	movl %r10d, -12(%rbp)
	notl -12(%rbp)
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
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl $10, _ui_a(%rip)
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
	movq $-1073741824, _ul_a(%rip)
	movq $1000, _ul_b(%rip)
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
	movl $1073741824, _ui_a(%rip)
	movl $3, _ui_b(%rip)
	call _multiplication
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
	movl $100, _ui_a(%rip)
	movl $4294967294, %r10d
	movl %r10d, _ui_b(%rip)
	call _division
	movl %eax, -36(%rbp)
	cmpl $0, -36(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $4294967294, %r10d
	movl %r10d, _ui_a(%rip)
	movl $2147483647, _ui_b(%rip)
	call _division_large_dividend
	movl %eax, -44(%rbp)
	cmpl $0, -44(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movq $1099511627775, %r10
	movq %r10, _ul_a(%rip)
	call _division_by_literal
	movl %eax, -52(%rbp)
	cmpl $0, -52(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movq $100, _ul_a(%rip)
	movq $-11, _ul_b(%rip)
	call _remaind
	movl %eax, -60(%rbp)
	cmpl $0, -60(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movl $4294967295, %r10d
	movl %r10d, _ui_a(%rip)
	call _complement
	movl %eax, -68(%rbp)
	cmpl $0, -68(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
