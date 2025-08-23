	.globl _i
	.bss
_i:
	.zero 4

	.bss
_i.4:
	.zero 4

	.globl _update_static_or_global
	.text
_update_static_or_global:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	cmpl $0, -12(%rbp)
	jE Lupdate_static_or_global.0.true
	movl -16(%rbp), %r10d
	movl %r10d, _i(%rip)
	jmp Lupdate_static_or_global.0.end
	Lupdate_static_or_global.0.true:
	movl -16(%rbp), %r10d
	movl %r10d, _i.4(%rip)
	Lupdate_static_or_global.0.end:
	movl _i.4(%rip), %eax
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
	subq $64, %rsp
	cmpl $0, _i(%rip)
	movl $0, -12(%rbp)
	setNE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $1, %edi
	movl $10, %esi
	call _update_static_or_global
	movl %eax, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	cmpl $10, _i(%rip)
	movl $0, -28(%rbp)
	setNE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.2.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $0, %edi
	movl $9, %esi
	call _update_static_or_global
	movl %eax, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -20(%rbp)
	cmpl $9, -20(%rbp)
	movl $0, -36(%rbp)
	setNE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.3.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	cmpl $10, _i(%rip)
	movl $0, -40(%rbp)
	setNE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.4.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $1, %edi
	movl $11, %esi
	call _update_static_or_global
	movl %eax, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -20(%rbp)
	cmpl $9, -20(%rbp)
	movl $0, -48(%rbp)
	setNE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.5.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	cmpl $11, _i(%rip)
	movl $0, -52(%rbp)
	setNE -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.6.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
