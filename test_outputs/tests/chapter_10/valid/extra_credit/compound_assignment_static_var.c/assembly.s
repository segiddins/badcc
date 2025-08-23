	.bss
_i.1:
	.zero 4

	.bss
_j.2:
	.zero 4

	.data
_k.3:
	.long 1
	.data
_l.4:
	.long 48
	.globl _f
	.text
_f:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl _i.1(%rip), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, _i.1(%rip)
	movl _j.2(%rip), %r10d
	movl %r10d, -16(%rbp)
	movl _i.1(%rip), %r10d
	subl %r10d, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, _j.2(%rip)
	movl _k.3(%rip), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %r11d
	imull _j.2(%rip), %r11d
	movl %r11d, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, _k.3(%rip)
	movl _l.4(%rip), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, _l.4(%rip)
	cmpl $3, _i.1(%rip)
	movl $0, -28(%rbp)
	setNE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lf.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.0.end
	Lf.0.true:
	Lf.0.end:
	movl $6, -32(%rbp)
	negl -32(%rbp)
	movl -32(%rbp), %r10d
	cmpl %r10d, _j.2(%rip)
	movl $0, -36(%rbp)
	setNE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lf.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.1.end
	Lf.1.true:
	Lf.1.end:
	movl $18, -40(%rbp)
	negl -40(%rbp)
	movl -40(%rbp), %r10d
	cmpl %r10d, _k.3(%rip)
	movl $0, -44(%rbp)
	setNE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lf.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.2.end
	Lf.2.true:
	Lf.2.end:
	cmpl $6, _l.4(%rip)
	movl $0, -48(%rbp)
	setNE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lf.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.3.end
	Lf.3.true:
	Lf.3.end:
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
	subq $32, %rsp
	call _f
	movl %eax, -12(%rbp)
	call _f
	movl %eax, -16(%rbp)
	call _f
	movl %eax, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
