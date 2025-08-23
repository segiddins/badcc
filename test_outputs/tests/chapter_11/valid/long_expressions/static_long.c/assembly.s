	.data
_foo:
	.quad 4294967290
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _foo(%rip), %r10
	movq %r10, -16(%rbp)
	addq $5, -16(%rbp)
	movq $4294967295, %r10
	cmpq %r10, -16(%rbp)
	movq $0, -24(%rbp)
	setE -24(%rbp)
	cmpq $0, -24(%rbp)
	jE Lmain.0.true
	movq $1152921504606846988, %r10
	movq %r10, _foo(%rip)
	movq $1152921504606846988, %r10
	cmpq %r10, _foo(%rip)
	movq $0, -32(%rbp)
	setE -32(%rbp)
	cmpq $0, -32(%rbp)
	jE Lmain.1.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
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
