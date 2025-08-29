	.globl _large_uint
	.data
_large_uint:
	.long 4294967294
	.globl _large_ulong
	.data
_large_ulong:
	.quad 4294967294
	.globl _one_hundred
	.data
_one_hundred:
	.long 100
	.globl _one_hundred_ulong
	.data
_one_hundred_ulong:
	.quad 100
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $160, %rsp
	movl _one_hundred(%rip), %r10d
	cmpl %r10d, _large_uint(%rip)
	movl $0, -12(%rbp)
	setB -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl _one_hundred(%rip), %r10d
	cmpl %r10d, _large_uint(%rip)
	movl $0, -16(%rbp)
	setBE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl _large_uint(%rip), %r10d
	cmpl %r10d, _one_hundred(%rip)
	movl $0, -20(%rbp)
	setAE -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl _large_uint(%rip), %r10d
	cmpl %r10d, _one_hundred(%rip)
	movl $0, -24(%rbp)
	setA -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl _large_uint(%rip), %r10d
	cmpl %r10d, _one_hundred(%rip)
	movl $0, -28(%rbp)
	setBE -28(%rbp)
	cmpl $0, -28(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	cmpl $0, -32(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl _large_uint(%rip), %r10d
	cmpl %r10d, _one_hundred(%rip)
	movl $0, -36(%rbp)
	setB -36(%rbp)
	cmpl $0, -36(%rbp)
	movl $0, -40(%rbp)
	setE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl _one_hundred(%rip), %r10d
	cmpl %r10d, _large_uint(%rip)
	movl $0, -44(%rbp)
	setA -44(%rbp)
	cmpl $0, -44(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.6.true
	movl $7, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.6.end
	Lmain.6.true:
	Lmain.6.end:
	movl _one_hundred(%rip), %r10d
	cmpl %r10d, _large_uint(%rip)
	movl $0, -52(%rbp)
	setAE -52(%rbp)
	cmpl $0, -52(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.7.true
	movl $8, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.7.end
	Lmain.7.true:
	Lmain.7.end:
	movq _one_hundred_ulong(%rip), %r10
	cmpq %r10, _large_ulong(%rip)
	movq $0, -64(%rbp)
	setB -64(%rbp)
	cmpq $0, -64(%rbp)
	jE Lmain.8.true
	movl $9, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.8.end
	Lmain.8.true:
	Lmain.8.end:
	movq _one_hundred_ulong(%rip), %r10
	cmpq %r10, _large_ulong(%rip)
	movq $0, -72(%rbp)
	setBE -72(%rbp)
	cmpq $0, -72(%rbp)
	jE Lmain.9.true
	movl $10, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.9.end
	Lmain.9.true:
	Lmain.9.end:
	movq _large_ulong(%rip), %r10
	cmpq %r10, _one_hundred_ulong(%rip)
	movq $0, -80(%rbp)
	setAE -80(%rbp)
	cmpq $0, -80(%rbp)
	jE Lmain.10.true
	movl $11, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.10.end
	Lmain.10.true:
	Lmain.10.end:
	movq _large_ulong(%rip), %r10
	cmpq %r10, _one_hundred_ulong(%rip)
	movq $0, -88(%rbp)
	setA -88(%rbp)
	cmpq $0, -88(%rbp)
	jE Lmain.11.true
	movl $12, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.11.end
	Lmain.11.true:
	Lmain.11.end:
	movq _large_ulong(%rip), %r10
	cmpq %r10, _one_hundred_ulong(%rip)
	movq $0, -96(%rbp)
	setBE -96(%rbp)
	cmpq $0, -96(%rbp)
	movq $0, -104(%rbp)
	setE -104(%rbp)
	cmpq $0, -104(%rbp)
	jE Lmain.12.true
	movl $13, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.12.end
	Lmain.12.true:
	Lmain.12.end:
	movq _large_ulong(%rip), %r10
	cmpq %r10, _one_hundred_ulong(%rip)
	movq $0, -112(%rbp)
	setB -112(%rbp)
	cmpq $0, -112(%rbp)
	movq $0, -120(%rbp)
	setE -120(%rbp)
	cmpq $0, -120(%rbp)
	jE Lmain.13.true
	movl $14, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.13.end
	Lmain.13.true:
	Lmain.13.end:
	movq _one_hundred_ulong(%rip), %r10
	cmpq %r10, _large_ulong(%rip)
	movq $0, -128(%rbp)
	setA -128(%rbp)
	cmpq $0, -128(%rbp)
	movq $0, -136(%rbp)
	setE -136(%rbp)
	cmpq $0, -136(%rbp)
	jE Lmain.14.true
	movl $15, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.14.end
	Lmain.14.true:
	Lmain.14.end:
	movq _one_hundred_ulong(%rip), %r10
	cmpq %r10, _large_ulong(%rip)
	movq $0, -144(%rbp)
	setAE -144(%rbp)
	cmpq $0, -144(%rbp)
	movq $0, -152(%rbp)
	setE -152(%rbp)
	cmpq $0, -152(%rbp)
	jE Lmain.15.true
	movl $16, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.15.end
	Lmain.15.true:
	Lmain.15.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
