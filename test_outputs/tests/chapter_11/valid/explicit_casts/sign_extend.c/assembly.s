	.globl _sign_extend
	.text
_sign_extend:
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
	movq -44(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl $10, %edi
	movq $10, %rsi
	call _sign_extend
	movq %rax, -16(%rbp)
	cmpq $0, -16(%rbp)
	movq $0, -24(%rbp)
	setE -24(%rbp)
	cmpq $0, -24(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $10, -28(%rbp)
	negl -28(%rbp)
	movq $10, -36(%rbp)
	negq -36(%rbp)
	movl -28(%rbp), %edi
	movq -36(%rbp), %rsi
	call _sign_extend
	movq %rax, -44(%rbp)
	cmpq $0, -44(%rbp)
	movq $0, -52(%rbp)
	setE -52(%rbp)
	cmpq $0, -52(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $100, %r11d
	movslq %r11d, %r10
	movq %r10, -60(%rbp)
	movq -60(%rbp), %r10
	movq %r10, -68(%rbp)
	cmpq $100, -68(%rbp)
	movq $0, -76(%rbp)
	setNE -76(%rbp)
	cmpq $0, -76(%rbp)
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
