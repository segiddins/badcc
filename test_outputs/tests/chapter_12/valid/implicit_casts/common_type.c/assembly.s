	.globl _int_gt_uint
	.text
_int_gt_uint:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, -20(%rbp)
	movl $0, -24(%rbp)
	setA -24(%rbp)
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
	.globl _int_gt_ulong
	.text
_int_gt_ulong:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	movq %rsi, -20(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -28(%rbp)
	movq -20(%rbp), %r10
	cmpq %r10, -28(%rbp)
	movq $0, -36(%rbp)
	setA -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _uint_gt_long
	.text
_uint_gt_long:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	movq %rsi, -20(%rbp)
	movl -12(%rbp), %r11d
	movq %r11, -28(%rbp)
	movq -20(%rbp), %r10
	cmpq %r10, -28(%rbp)
	movq $0, -36(%rbp)
	setG -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _uint_lt_ulong
	.text
_uint_lt_ulong:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	movq %rsi, -20(%rbp)
	movl -12(%rbp), %r11d
	movq %r11, -28(%rbp)
	movq -20(%rbp), %r10
	cmpq %r10, -28(%rbp)
	movq $0, -36(%rbp)
	setB -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _long_gt_ulong
	.text
_long_gt_ulong:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -32(%rbp)
	movq -24(%rbp), %r10
	cmpq %r10, -32(%rbp)
	movq $0, -40(%rbp)
	setA -40(%rbp)
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
	.globl _ternary_int_uint
	.text
_ternary_int_uint:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	cmpl $0, -12(%rbp)
	jE Lternary_int_uint.0.true
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	jmp Lternary_int_uint.0.end
	Lternary_int_uint.0.true:
	movl -20(%rbp), %r10d
	movl %r10d, -28(%rbp)
	Lternary_int_uint.0.end:
	movl -28(%rbp), %r11d
	movq %r11, -36(%rbp)
	movq -36(%rbp), %r10
	movq %r10, -44(%rbp)
	movq $4294967295, %r10
	cmpq %r10, -44(%rbp)
	movq $0, -52(%rbp)
	setE -52(%rbp)
	movl -52(%rbp), %r10d
	movl %r10d, -56(%rbp)
	movl -56(%rbp), %eax
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
	subq $96, %rsp
	movl $100, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %edi
	movl $100, %esi
	call _int_gt_uint
	movl %eax, -16(%rbp)
	cmpl $0, -16(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $1, -24(%rbp)
	negl -24(%rbp)
	movl -24(%rbp), %edi
	movq $-10, %rsi
	call _int_gt_ulong
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
	movq $100, -40(%rbp)
	negq -40(%rbp)
	movl $100, %edi
	movq -40(%rbp), %rsi
	call _uint_gt_long
	movl %eax, -44(%rbp)
	cmpl $0, -44(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $1073741824, %edi
	movq $34359738368, %rsi
	call _uint_lt_ulong
	movl %eax, -52(%rbp)
	cmpl $0, -52(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $1, -64(%rbp)
	negq -64(%rbp)
	movq -64(%rbp), %rdi
	movq $1000, %rsi
	call _long_gt_ulong
	movl %eax, -68(%rbp)
	cmpl $0, -68(%rbp)
	movl $0, -72(%rbp)
	setE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $1, -76(%rbp)
	negl -76(%rbp)
	movl $1, %edi
	movl -76(%rbp), %esi
	movl $1, %edx
	call _ternary_int_uint
	movl %eax, -80(%rbp)
	cmpl $0, -80(%rbp)
	movl $0, -84(%rbp)
	setE -84(%rbp)
	cmpl $0, -84(%rbp)
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
