	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $96, %rsp
	movl $4294967200, %r10d
	cmpl %r10d, _ui(%rip)
	movl $0, -12(%rbp)
	setNE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $1, -16(%rbp)
	negl -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, _ui(%rip)
	call _return_uint
	movl %eax, -24(%rbp)
	movl -24(%rbp), %r11d
	movq %r11, -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -40(%rbp)
	movq $4294967295, %r10
	cmpq %r10, -40(%rbp)
	movq $0, -48(%rbp)
	setNE -48(%rbp)
	cmpq $0, -48(%rbp)
	jE Lmain.1.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	call _return_uint_as_signed
	movl %eax, -52(%rbp)
	movl -52(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -60(%rbp)
	movq -60(%rbp), %r10
	movq %r10, -40(%rbp)
	movq $1, -68(%rbp)
	negq -68(%rbp)
	movq -68(%rbp), %r10
	cmpq %r10, -40(%rbp)
	movq $0, -76(%rbp)
	setNE -76(%rbp)
	cmpq $0, -76(%rbp)
	jE Lmain.2.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	call _return_uint_as_long
	movq %rax, -84(%rbp)
	movq -84(%rbp), %r10
	movq %r10, -40(%rbp)
	movq $4294967295, %r10
	cmpq %r10, -40(%rbp)
	movq $0, -92(%rbp)
	setNE -92(%rbp)
	cmpq $0, -92(%rbp)
	jE Lmain.3.true
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
