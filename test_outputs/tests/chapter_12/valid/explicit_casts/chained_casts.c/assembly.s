	.globl _ui
	.data
_ui:
	.long 4294967200
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl _ui(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -20(%rbp)
	movq $96, -28(%rbp)
	negq -28(%rbp)
	movq -28(%rbp), %r10
	cmpq %r10, -20(%rbp)
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
	movl _ui(%rip), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -48(%rbp)
	cmpq $-96, -48(%rbp)
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	cmpq $0, -56(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
