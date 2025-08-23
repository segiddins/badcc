	.globl _l
	.bss
_l:
	.zero 8

	.globl _l2
	.bss
_l2:
	.zero 8

	.globl _compare_constants
	.text
_compare_constants:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $8589934593, %r11
	cmpq $255, %r11
	movq $0, -16(%rbp)
	setG -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _compare_constants_2
	.text
_compare_constants_2:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $8589934593, %r10
	movq $255, %r11
	cmpq %r10, %r11
	movq $0, -16(%rbp)
	setL -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _l_geq_2_60
	.text
_l_geq_2_60:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $1152921504606846976, %r10
	cmpq %r10, _l(%rip)
	movq $0, -16(%rbp)
	setGE -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _uint_max_leq_l
	.text
_uint_max_leq_l:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq $4294967295, %r11
	cmpq _l(%rip), %r11
	movq $0, -16(%rbp)
	setLE -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _l_eq_l2
	.text
_l_eq_l2:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq _l2(%rip), %r10
	cmpq %r10, _l(%rip)
	movq $0, -16(%rbp)
	setE -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %eax
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
	call _compare_constants
	movl %eax, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	call _compare_constants_2
	movl %eax, -20(%rbp)
	cmpl $0, -20(%rbp)
	movl $0, -24(%rbp)
	setE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq $9223372036854775807, %r10
	movq %r10, -32(%rbp)
	negq -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, _l(%rip)
	call _l_geq_2_60
	movl %eax, -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	call _uint_max_leq_l
	movl %eax, -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq $1152921504606846976, %r10
	movq %r10, _l(%rip)
	call _l_geq_2_60
	movl %eax, -44(%rbp)
	cmpl $0, -44(%rbp)
	movl $0, -48(%rbp)
	setE -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	call _uint_max_leq_l
	movl %eax, -52(%rbp)
	cmpl $0, -52(%rbp)
	movl $0, -56(%rbp)
	setE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.5.true
	movl $6, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.5.end
	Lmain.5.true:
	Lmain.5.end:
	movq _l(%rip), %r10
	movq %r10, _l2(%rip)
	call _l_eq_l2
	movl %eax, -60(%rbp)
	cmpl $0, -60(%rbp)
	movl $0, -64(%rbp)
	setE -64(%rbp)
	cmpl $0, -64(%rbp)
	jE Lmain.6.true
	movl $7, %eax
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
