	.globl _x
	.data
_x:
	.quad 5
	.globl _add_large
	.text
_add_large:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _x(%rip), %r10
	movq %r10, -16(%rbp)
	movq $4294967290, %r10
	addq %r10, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, _x(%rip)
	movq $4294967295, %r10
	cmpq %r10, _x(%rip)
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
	.globl _subtract_large
	.text
_subtract_large:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _x(%rip), %r10
	movq %r10, -16(%rbp)
	movq $4294967290, %r10
	subq %r10, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, _x(%rip)
	cmpq $5, _x(%rip)
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
	.globl _multiply_by_large
	.text
_multiply_by_large:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _x(%rip), %r10
	movq %r10, -16(%rbp)
	movq -16(%rbp), %r11
	movq $4294967290, %r10
	imulq %r10, %r11
	movq %r11, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, _x(%rip)
	movq $21474836450, %r10
	cmpq %r10, _x(%rip)
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
	call _add_large
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
	call _subtract_large
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
	call _multiply_by_large
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
