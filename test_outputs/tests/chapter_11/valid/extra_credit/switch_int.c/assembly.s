	.globl _switch_on_int
	.text
_switch_on_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl %edi, -12(%rbp)
	jmp Lswitch.0.cases
	Lswitch.0.5:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.0:
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.neg1:
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lswitch.0.default:
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lswitch.0
	Lswitch.0.cases:
	movl $5, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.5
	movl $0, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.0
	movl $-1, %r11d
	cmpl -12(%rbp), %r11d
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lswitch.0.neg1
	jmp Lswitch.0.default
	Lswitch.0:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $5, %edi
	call _switch_on_int
	movl %eax, -12(%rbp)
	cmpl $0, -12(%rbp)
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
	movl $0, %edi
	call _switch_on_int
	movl %eax, -20(%rbp)
	cmpl $1, -20(%rbp)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl $1, -28(%rbp)
	negl -28(%rbp)
	movl -28(%rbp), %edi
	call _switch_on_int
	movl %eax, -32(%rbp)
	cmpl $2, -32(%rbp)
	movl $0, -36(%rbp)
	setNE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $0, %edi
	call _switch_on_int
	movl %eax, -40(%rbp)
	cmpl $1, -40(%rbp)
	movl $0, -44(%rbp)
	setNE -44(%rbp)
	cmpl $0, -44(%rbp)
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
