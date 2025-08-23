	.globl _truncate
	.text
_truncate:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, -16(%rbp)
	movl %esi, -20(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -20(%rbp), %r10d
	cmpl %r10d, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	movl -32(%rbp), %eax
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
	movq $10, %rdi
	movl $10, %esi
	call _truncate
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
	movq $10, -24(%rbp)
	negq -24(%rbp)
	movl $10, -28(%rbp)
	negl -28(%rbp)
	movq -24(%rbp), %rdi
	movl -28(%rbp), %esi
	call _truncate
	movl %eax, -32(%rbp)
	cmpl $0, -32(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $17179869189, %rdi
	movl $5, %esi
	call _truncate
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
	movq $17179869179, %r10
	movq %r10, -52(%rbp)
	negq -52(%rbp)
	movq -52(%rbp), %rdi
	movl $5, %esi
	call _truncate
	movl %eax, -56(%rbp)
	cmpl $0, -56(%rbp)
	movl $0, -60(%rbp)
	setE -60(%rbp)
	cmpl $0, -60(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $5, -64(%rbp)
	movl -64(%rbp), %r10d
	movl %r10d, -68(%rbp)
	cmpl $5, -68(%rbp)
	movl $0, -72(%rbp)
	setNE -72(%rbp)
	cmpl $0, -72(%rbp)
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
