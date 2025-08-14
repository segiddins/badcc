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
	subq $32, %rsp
	movl _i.1(%rip), %r10d
	movl %r10d, _i.1(%rip)
	addl $1, _i.1(%rip)
	movl _j.2(%rip), %r10d
	movl %r10d, _j.2(%rip)
	movl _i.1(%rip), %r10d
	subl %r10d, _j.2(%rip)
	movl _k.3(%rip), %r10d
	movl %r10d, _k.3(%rip)
	movl _k.3(%rip), %r11d
	imull _j.2(%rip), %r11d
	movl %r11d, _k.3(%rip)
	movl _l.4(%rip), %eax
	cdq
	movl $2, %r10d
	idivl %r10d
	movl %eax, _l.4(%rip)
	cmpl $3, _i.1(%rip)
	movl $0, -12(%rbp)
	setNE -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lf.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.0.end
	Lf.0.true:
	Lf.0.end:
	movl $6, -16(%rbp)
	negl -16(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, _j.2(%rip)
	movl $0, -20(%rbp)
	setNE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lf.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.1.end
	Lf.1.true:
	Lf.1.end:
	movl $18, -24(%rbp)
	negl -24(%rbp)
	movl -24(%rbp), %r10d
	cmpl %r10d, _k.3(%rip)
	movl $0, -28(%rbp)
	setNE -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lf.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lf.2.end
	Lf.2.true:
	Lf.2.end:
	cmpl $6, _l.4(%rip)
	movl $0, -32(%rbp)
	setNE -32(%rbp)
	cmpl $0, -32(%rbp)
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
