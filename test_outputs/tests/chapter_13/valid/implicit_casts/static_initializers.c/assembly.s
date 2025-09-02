	.globl _d1
	.data
_d1:
	.quad 0x41dfffffffc00000
	.globl _d2
	.data
_d2:
	.quad 0x41efffffffe00000
	.globl _d3
	.data
_d3:
	.quad 0x43d0000000000002
	.globl _d4
	.data
_d4:
	.quad 0x43d0000000000002
	.globl _d5
	.data
_d5:
	.quad 0xc3e0000000000000
	.globl _d6
	.data
_d6:
	.quad 0x43d0000000000002
	.globl _d7
	.data
_d7:
	.quad 0xc3dfffffffffffff
	.data
_i:
	.long 4
	.globl _l
	.data
_l:
	.quad 4611686018427389952
	.globl _u
	.data
_u:
	.long 4294967292
	.globl _ul
	.data
_ul:
	.quad 9223372036854775807
	.globl _uninitialized
	.bss
_uninitialized:
	.zero 8

	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $96, %rsp
	movq $4746794007244308480, %r10
	movq %r10, %xmm14
	movsd _d1(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -16(%rbp)
	setNE -16(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $4751297606873776128, %r10
	movq %r10, %xmm14
	movsd _d2(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -24(%rbp)
	setNE -24(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $4886405595696988162, %r10
	movq %r10, %xmm14
	movsd _d3(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -32(%rbp)
	setNE -32(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -32(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movsd _d3(%rip), %xmm14
	movsd _d4(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -40(%rbp)
	setNE -40(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -40(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $4890909195324358656, %r10
	movq %r10, %xmm14
	movsd _d5(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -48(%rbp)
	setNE -48(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -48(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movsd _d3(%rip), %xmm14
	movsd _d6(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -56(%rbp)
	setNE -56(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -56(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movsd _d5(%rip), %xmm14
	movsd _d7(%rip), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -64(%rbp)
	setNE -64(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -64(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movq $0, %r10
	movq %r10, %xmm14
	movsd _uninitialized(%rip), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	cmpl $4, _i(%rip)
	movl $0, -68(%rbp)
	setNE -68(%rbp)
	cmpl $0, -68(%rbp)
	jE Lmain.8.true
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.8.end
	Lmain.8.true:
	Lmain.8.end:
	movl $4294967292, %r10d
	cmpl %r10d, _u(%rip)
	movl $0, -72(%rbp)
	setNE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lmain.9.true
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.9.end
	Lmain.9.true:
	Lmain.9.end:
	movq $4611686018427389952, %r10
	cmpq %r10, _l(%rip)
	movq $0, -80(%rbp)
	setNE -80(%rbp)
	cmpq $0, -80(%rbp)
	jE Lmain.10.true
	movl $11, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.10.end
	Lmain.10.true:
	Lmain.10.end:
	cmpq $-2048, _ul(%rip)
	movq $0, -88(%rbp)
	setNE -88(%rbp)
	cmpq $0, -88(%rbp)
	jE Lmain.11.true
	movl $12, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.11.end
	Lmain.11.true:
	Lmain.11.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
