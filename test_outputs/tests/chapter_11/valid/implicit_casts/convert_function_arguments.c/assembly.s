	.globl _foo
	.text
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $128, %rsp
	movq %rdi, -16(%rbp)
	movl %esi, -20(%rbp)
	movl %edx, -24(%rbp)
	movl %ecx, -28(%rbp)
	movq %r8, -36(%rbp)
	movl %r9d, -40(%rbp)
	movq 16(%rbp), %r10
	movq %r10, -48(%rbp)
	movl 24(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movq $1, -60(%rbp)
	negq -60(%rbp)
	movq -60(%rbp), %r10
	cmpq %r10, -16(%rbp)
	movq $0, -68(%rbp)
	setNE -68(%rbp)
	cmpq $0, -68(%rbp)
	jE Lfoo.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.0.end
	Lfoo.0.true:
	Lfoo.0.end:
	cmpl $2, -20(%rbp)
	movl $0, -72(%rbp)
	setNE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lfoo.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.1.end
	Lfoo.1.true:
	Lfoo.1.end:
	cmpl $0, -24(%rbp)
	movl $0, -76(%rbp)
	setNE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lfoo.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.2.end
	Lfoo.2.true:
	Lfoo.2.end:
	movl $5, -80(%rbp)
	negl -80(%rbp)
	movl -80(%rbp), %r10d
	cmpl %r10d, -28(%rbp)
	movl $0, -84(%rbp)
	setNE -84(%rbp)
	cmpl $0, -84(%rbp)
	jE Lfoo.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.3.end
	Lfoo.3.true:
	Lfoo.3.end:
	movq $101, -92(%rbp)
	negq -92(%rbp)
	movq -92(%rbp), %r10
	cmpq %r10, -36(%rbp)
	movq $0, -100(%rbp)
	setNE -100(%rbp)
	cmpq $0, -100(%rbp)
	jE Lfoo.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.4.end
	Lfoo.4.true:
	Lfoo.4.end:
	movl $123, -104(%rbp)
	negl -104(%rbp)
	movl -104(%rbp), %r10d
	cmpl %r10d, -40(%rbp)
	movl $0, -108(%rbp)
	setNE -108(%rbp)
	cmpl $0, -108(%rbp)
	jE Lfoo.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.5.end
	Lfoo.5.true:
	Lfoo.5.end:
	movq $10, -116(%rbp)
	negq -116(%rbp)
	movq -116(%rbp), %r10
	cmpq %r10, -48(%rbp)
	movq $0, -124(%rbp)
	setNE -124(%rbp)
	cmpq $0, -124(%rbp)
	jE Lfoo.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.6.end
	Lfoo.6.true:
	Lfoo.6.end:
	cmpl $1234, -52(%rbp)
	movl $0, -128(%rbp)
	setNE -128(%rbp)
	cmpl $0, -128(%rbp)
	jE Lfoo.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfoo.7.end
	Lfoo.7.true:
	Lfoo.7.end:
	movl $0, %eax
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
	subq $160, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movq $4294967298, %r10
	movq %r10, -24(%rbp)
	movq $4294967296, %r10
	movq %r10, -32(%rbp)
	negq -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -40(%rbp)
	movq $21474836475, %r10
	movq %r10, -48(%rbp)
	movl $101, -52(%rbp)
	negl -52(%rbp)
	movl -52(%rbp), %r10d
	movl %r10d, -56(%rbp)
	movl $123, -60(%rbp)
	negl -60(%rbp)
	movl -60(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -68(%rbp)
	movq -68(%rbp), %r10
	movq %r10, -76(%rbp)
	movl $10, -80(%rbp)
	negl -80(%rbp)
	movl -80(%rbp), %r10d
	movl %r10d, -84(%rbp)
	movq $9223372036854774574, %r10
	movq %r10, -92(%rbp)
	negq -92(%rbp)
	movq -92(%rbp), %r10
	movq %r10, -100(%rbp)
	movl -16(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -108(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -112(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -116(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -120(%rbp)
	movl -56(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -128(%rbp)
	movl -76(%rbp), %r10d
	movl %r10d, -132(%rbp)
	movl -84(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -140(%rbp)
	movl -100(%rbp), %r10d
	movl %r10d, -144(%rbp)
	movq -108(%rbp), %rdi
	movl -112(%rbp), %esi
	movl -116(%rbp), %edx
	movl -120(%rbp), %ecx
	movq -128(%rbp), %r8
	movl -132(%rbp), %r9d
	movl -144(%rbp), %eax
	pushq %rax
	movq -140(%rbp), %rax
	pushq %rax
	call _foo
	addq $16, %rsp
	movl %eax, -148(%rbp)
	movl -148(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
