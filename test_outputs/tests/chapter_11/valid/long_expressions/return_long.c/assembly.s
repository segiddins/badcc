	.globl _add
	.text
_add:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -24(%rbp)
	movl -16(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -32(%rbp)
	movq -24(%rbp), %r10
	movq %r10, -40(%rbp)
	movq -32(%rbp), %r10
	addq %r10, -40(%rbp)
	movq -40(%rbp), %rax
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
	subq $32, %rsp
	movl $2147483645, %edi
	movl $2147483645, %esi
	call _add
	movq %rax, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movq $4294967290, %r10
	cmpq %r10, -24(%rbp)
	movq $0, -32(%rbp)
	setE -32(%rbp)
	cmpq $0, -32(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
