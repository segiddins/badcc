	.globl _return_truncated_long
	.text
_return_truncated_long:
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
	.globl _truncate_on_assignment
	.text
_truncate_on_assignment:
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
	subq $96, %rsp
	movq $4294967298, %rdi
	call _return_truncated_long
	movl %eax, -12(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -20(%rbp)
	movq -20(%rbp), %r10
	movq %r10, -28(%rbp)
	cmpq $2, -28(%rbp)
	movq $0, -36(%rbp)
	setNE -36(%rbp)
	cmpq $0, -36(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $10, -40(%rbp)
	negl -40(%rbp)
	movl -40(%rbp), %edi
	call _return_extended_int
	movq %rax, -48(%rbp)
	movq -48(%rbp), %r10
	movq %r10, -28(%rbp)
	movl $10, -52(%rbp)
	negl -52(%rbp)
	movl -52(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -60(%rbp)
	movq -60(%rbp), %r10
	cmpq %r10, -28(%rbp)
	movq $0, -68(%rbp)
	setNE -68(%rbp)
	cmpq $0, -68(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $2, -72(%rbp)
	cmpl $2, -72(%rbp)
	movl $0, -76(%rbp)
	setNE -76(%rbp)
	cmpl $0, -76(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $17179869184, %rdi
	movl $0, %esi
	call _truncate_on_assignment
	movl %eax, -80(%rbp)
	cmpl $0, -80(%rbp)
	movl $0, -84(%rbp)
	setE -84(%rbp)
	cmpl $0, -84(%rbp)
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
