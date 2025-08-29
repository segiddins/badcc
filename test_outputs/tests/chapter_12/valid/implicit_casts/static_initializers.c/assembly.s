	.globl _i
	.data
_i:
	.long -2147483646
	.globl _i2
	.data
_i2:
	.long -2147483498
	.globl _l
	.data
_l:
	.quad -9223372036854775716
	.globl _l2
	.data
_l2:
	.quad 2147483650
	.globl _u
	.data
_u:
	.long 2147483660
	.globl _ui2
	.data
_ui2:
	.long 2147483798
	.globl _ul
	.data
_ul:
	.quad 4294967294
	.globl _ul2
	.data
_ul2:
	.quad 9223372036854775798
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl $2147483660, %r10d
	cmpl %r10d, _u(%rip)
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
	movl $2147483646, -16(%rbp)
	negl -16(%rbp)
	movl -16(%rbp), %r10d
	cmpl %r10d, _i(%rip)
	movl $0, -20(%rbp)
	setNE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $9223372036854775716, %r10
	movq %r10, -28(%rbp)
	negq -28(%rbp)
	movq -28(%rbp), %r10
	cmpq %r10, _l(%rip)
	movq $0, -36(%rbp)
	setNE -36(%rbp)
	cmpq $0, -36(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $2147483650, %r10
	cmpq %r10, _l2(%rip)
	movq $0, -44(%rbp)
	setNE -44(%rbp)
	cmpq $0, -44(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $4294967294, %r10
	cmpq %r10, _ul(%rip)
	movq $0, -52(%rbp)
	setNE -52(%rbp)
	cmpq $0, -52(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movq $9223372036854775798, %r10
	cmpq %r10, _ul2(%rip)
	movq $0, -60(%rbp)
	setNE -60(%rbp)
	cmpq $0, -60(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl $2147483498, -64(%rbp)
	negl -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, _i2(%rip)
	movl $0, -68(%rbp)
	setNE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movl $2147483798, %r10d
	cmpl %r10d, _ui2(%rip)
	movl $0, -72(%rbp)
	setNE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
