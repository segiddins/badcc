	.globl _int_to_ulong
	.text
_int_to_ulong:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	movq %rsi, -20(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -28(%rbp)
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
	.globl _uint_to_long
	.text
_uint_to_long:
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
	.globl _uint_to_ulong
	.text
_uint_to_ulong:
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
	setE -36(%rbp)
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
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $10, %edi
	movq $10, %rsi
	call _int_to_ulong
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
	movl $10, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %edi
	movq $-10, %rsi
	call _int_to_ulong
	movl %eax, -24(%rbp)
	cmpl $0, -24(%rbp)
	movl $0, -28(%rbp)
	setE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $4294967200, %edi
	movq $4294967200, %rsi
	call _uint_to_long
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
	movl $4294967200, %edi
	movq $4294967200, %rsi
	call _uint_to_ulong
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
	movl $4294967200, %r11d
	movq %r11, -52(%rbp)
	movq $4294967200, %r10
	cmpq %r10, -52(%rbp)
	movq $0, -60(%rbp)
	setNE -60(%rbp)
	cmpq $0, -60(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
