	.globl _uint_to_int
	.text
_uint_to_int:
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
	setE -24(%rbp)
	movl -24(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _int_to_uint
	.text
_int_to_uint:
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
	.globl _ulong_to_long
	.text
_ulong_to_long:
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
	.globl _long_to_ulong
	.text
_long_to_ulong:
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
	subq $64, %rsp
	movl $10, %edi
	movl $10, %esi
	call _int_to_uint
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
	movl $10, %edi
	movl $10, %esi
	call _uint_to_int
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
	movq $1000, -32(%rbp)
	negq -32(%rbp)
	movq -32(%rbp), %rdi
	movq $-1000, %rsi
	call _long_to_ulong
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
	movq $1000, -48(%rbp)
	negq -48(%rbp)
	movq $-1000, %rdi
	movq -48(%rbp), %rsi
	call _ulong_to_long
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
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
