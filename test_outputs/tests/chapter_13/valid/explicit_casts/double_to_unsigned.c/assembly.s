	.globl _double_to_uint
	.text
_double_to_uint:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd %xmm0, -16(%rbp)
	cvttsd2siq -16(%rbp), %r10
	movl %r10, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _double_to_ulong
	.text
_double_to_ulong:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd %xmm0, -16(%rbp)
	cvttsd2siq -16(%rbp), %r10
	movl %r10, -24(%rbp)
	movq -24(%rbp), %rax
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
	movq $4622325772547050701, %r10
	movq %r10, %xmm0
	call _double_to_uint
	movl %eax, -12(%rbp)
	cmpl $10, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $4746794007463460864, %r10
	movq %r10, %xmm0
	call _double_to_uint
	movl %eax, -20(%rbp)
	movl -20(%rbp), %r11d
	movq %r11, -28(%rbp)
	movq $2147483750, %r10
	cmpq %r10, -28(%rbp)
	movq $0, -36(%rbp)
	setNE -36(%rbp)
	cmpq $0, -36(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $4764808405758050304, %r10
	movq %r10, %xmm0
	call _double_to_ulong
	movq %rax, -44(%rbp)
	movq $34359738368, %r10
	cmpq %r10, -44(%rbp)
	movq $0, -52(%rbp)
	setNE -52(%rbp)
	cmpq $0, -52(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $4884153795883304960, %r10
	movq %r10, %xmm0
	call _double_to_ulong
	movq %rax, -60(%rbp)
	movq $3458764513821589504, %r10
	cmpq %r10, -60(%rbp)
	movq $0, -68(%rbp)
	setNE -68(%rbp)
	cmpq $0, -68(%rbp)
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
