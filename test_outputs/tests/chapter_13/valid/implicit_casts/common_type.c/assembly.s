	.globl _ten
	.data
_ten:
	.long 10
	.globl _lt
	.text
_lt:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq %rdi, -16(%rbp)
	movsd %xmm0, -24(%rbp)
	movq -16(%rbp), %r10
	cvtsi2sdq %r10, %xmm15
	movq %xmm15, -32(%rbp)
	movsd -32(%rbp), %xmm14
	movsd -24(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -40(%rbp)
	setB -40(%rbp)
	cvttsd2sil -40(%rbp), %r11d
	movl %r11d, -44(%rbp)
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _tern_double_flag
	.text
_tern_double_flag:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movsd %xmm0, -16(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -16(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Ltern_double_flag.0.true
	movl $30, -20(%rbp)
	negl -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -24(%rbp)
	jmp Ltern_double_flag.0.end
	Ltern_double_flag.0.true:
	movq $10, -24(%rbp)
	Ltern_double_flag.0.end:
	movl -24(%rbp), %r10d
	cvtsi2sdl %r10d, %xmm15
	movl %xmm15, -32(%rbp)
	movsd -32(%rbp), %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %r10
	movq %r10, %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _tern_double_result
	.text
_tern_double_result:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	cmpl $0, -12(%rbp)
	jE Ltern_double_result.0.true
	movq $4617315517961601024, %r10
	movq %r10, -20(%rbp)
	jmp Ltern_double_result.0.end
	Ltern_double_result.0.true:
	movq $-4332462841530417154, %r10
	movq %r10, -20(%rbp)
	Ltern_double_result.0.end:
	movsd -20(%rbp), %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	movq $0, %r10
	movq %r10, %xmm0
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _multiply
	.text
_multiply:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl _ten(%rip), %r10d
	cvtsi2sdl %r10d, %xmm15
	movl %xmm15, -16(%rbp)
	movq $4622241330054037504, %r10
	movq %r10, -24(%rbp)
	movsd -24(%rbp), %xmm15
	mulsd -16(%rbp), %xmm15
	movsd %xmm15, -24(%rbp)
	cvttsd2sil -24(%rbp), %r11d
	movl %r11d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	cmpl $107, -32(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	movl -36(%rbp), %eax
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
	subq $112, %rsp
	movq $4845873199050658814, %r10
	movq %r10, -16(%rbp)
	movq $-9223372036854775808, %r10
	xorq %r10, -16(%rbp)
	movq $9007199254751227, %r10
	movq %r10, -24(%rbp)
	negq -24(%rbp)
	movq -24(%rbp), %rdi
	movsd -16(%rbp), %xmm0
	call _lt
	movl %eax, -28(%rbp)
	cmpl $0, -28(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movq $4626322717216342016, %r10
	movq %r10, %xmm0
	call _tern_double_flag
	movsd %xmm0, -36(%rbp)
	movq $4895412794951729152, %r10
	movq %r10, %xmm14
	movsd -36(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -44(%rbp)
	setNE -44(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -44(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $0, %r10
	movq %r10, %xmm0
	call _tern_double_flag
	movsd %xmm0, -52(%rbp)
	movq $4621819117588971520, %r10
	movq %r10, %xmm14
	movsd -52(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -60(%rbp)
	setNE -60(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -60(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl $1, %edi
	call _tern_double_result
	movsd %xmm0, -68(%rbp)
	movq $4617315517961601024, %r10
	movq %r10, %xmm14
	movsd -68(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -76(%rbp)
	setNE -76(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -76(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movl $0, %edi
	call _tern_double_result
	movsd %xmm0, -84(%rbp)
	movq $4890909195324358657, %r10
	movq %r10, %xmm14
	movsd -84(%rbp), %xmm15
	comisd %xmm14, %xmm15
	movq $0, -92(%rbp)
	setNE -92(%rbp)
	movq $0, %r10
	movq %r10, %xmm14
	movsd -92(%rbp), %xmm15
	comisd %xmm14, %xmm15
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	call _multiply
	movl %eax, -96(%rbp)
	cmpl $0, -96(%rbp)
	movl $0, -100(%rbp)
	setE -100(%rbp)
	cmpl $0, -100(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
