	.globl _check_int
	.text
_check_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _check_long
	.text
_check_long:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
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
	.globl _check_ulong
	.text
_check_ulong:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
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
	.globl _return_extended_uint
	.text
_return_extended_uint:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl -12(%rbp), %r11d
	movq %r11, -20(%rbp)
	movq -20(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _return_extended_int
	.text
_return_extended_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -20(%rbp)
	movq -20(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _return_truncated_ulong
	.text
_return_truncated_ulong:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, -16(%rbp)
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
	.globl _extend_on_assignment
	.text
_extend_on_assignment:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	movq %rsi, -20(%rbp)
	movl -12(%rbp), %r11d
	movq %r11, -28(%rbp)
	movq -28(%rbp), %r10
	movq %r10, -36(%rbp)
	movq -20(%rbp), %r10
	cmpq %r10, -36(%rbp)
	movq $0, -44(%rbp)
	setE -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -48(%rbp)
	movl -48(%rbp), %eax
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
	subq $144, %rsp
	movl $5, %edi
	movl $5, %esi
	call _check_int
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
	movq $2147483658, %rdi
	movq $2147483658, %rsi
	call _check_long
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
	movl $1, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -36(%rbp)
	movq -36(%rbp), %rdi
	movq $-1, %rsi
	call _check_ulong
	movl %eax, -40(%rbp)
	cmpl $0, -40(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $2147483658, %edi
	call _return_extended_uint
	movq %rax, -52(%rbp)
	movq $2147483658, %r10
	cmpq %r10, -52(%rbp)
	movq $0, -60(%rbp)
	setNE -60(%rbp)
	cmpq $0, -60(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $1, -64(%rbp)
	negl -64(%rbp)
	movl -64(%rbp), %edi
	call _return_extended_int
	movq %rax, -72(%rbp)
	cmpq $-1, -72(%rbp)
	movq $0, -80(%rbp)
	setNE -80(%rbp)
	cmpq $0, -80(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movq $1125902054326372, %rdi
	call _return_truncated_ulong
	movl %eax, -84(%rbp)
	movl -84(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -92(%rbp)
	movq -92(%rbp), %r10
	movq %r10, -100(%rbp)
	movq $2147483548, -108(%rbp)
	negq -108(%rbp)
	movq -108(%rbp), %r10
	cmpq %r10, -100(%rbp)
	movq $0, -116(%rbp)
	setNE -116(%rbp)
	cmpq $0, -116(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl $2147483658, %edi
	movq $2147483658, %rsi
	call _extend_on_assignment
	movl %eax, -120(%rbp)
	cmpl $0, -120(%rbp)
	movl $0, -124(%rbp)
	setE -124(%rbp)
	cmpl $0, -124(%rbp)
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movl $-100, -128(%rbp)
	movl $100, -132(%rbp)
	negl -132(%rbp)
	movl -132(%rbp), %r10d
	cmpl %r10d, -128(%rbp)
	movl $0, -136(%rbp)
	setNE -136(%rbp)
	cmpl $0, -136(%rbp)
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
