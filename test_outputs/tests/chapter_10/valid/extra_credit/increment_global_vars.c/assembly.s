	.globl _i
	.bss
_i:
	.zero 4

	.globl _j
	.bss
_j:
	.zero 4

	.globl _incr_i
	.text
_incr_i:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	cmpl $1, _i(%rip)
	movl $0, -12(%rbp)
	setE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lincr_i.0.true
	movl _i(%rip), %r10d
	movl %r10d, -16(%rbp)
	movl _i(%rip), %r10d
	movl %r10d, _i(%rip)
	addl $1, _i(%rip)
	movl _i(%rip), %r10d
	movl %r10d, _i(%rip)
	addl $1, _i(%rip)
	jmp Lincr_i.0.end
	Lincr_i.0.true:
	Lincr_i.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _decr_j
	.text
_decr_j:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	cmpl %r10d, _j(%rip)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Ldecr_j.0.true
	movl _j(%rip), %r10d
	movl %r10d, -20(%rbp)
	movl _j(%rip), %r10d
	movl %r10d, _j(%rip)
	addl $-1, _j(%rip)
	jmp Ldecr_j.0.end
	Ldecr_j.0.true:
	Ldecr_j.0.end:
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
	subq $48, %rsp
	movl _i(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl _i(%rip), %r10d
	movl %r10d, _i(%rip)
	addl $1, _i(%rip)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $0, -16(%rbp)
	jmp Lmain.0.end
	Lmain.0.true:
	call _incr_i
	movl %eax, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -16(%rbp)
	Lmain.0.end:
	cmpl $3, _i(%rip)
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
	movl _j(%rip), %r10d
	movl %r10d, _j(%rip)
	addl $-1, _j(%rip)
	cmpl $0, _j(%rip)
	jE Lmain.2.true
	call _decr_j
	movl %eax, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	jmp Lmain.2.end
	Lmain.2.true:
	movl $0, -32(%rbp)
	Lmain.2.end:
	movl $2, -36(%rbp)
	negl -36(%rbp)
	movl -36(%rbp), %r10d
	cmpl %r10d, _j(%rip)
	movl $0, -40(%rbp)
	setNE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.3.true
	movl $2, %eax
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
