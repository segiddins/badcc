	.data
_shiftcount.2:
	.long 5
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl $1, -12(%rbp)
	negl -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -20(%rbp), %r11d
	shll $2, %r11d
	movl %r11d, -20(%rbp)
	movl -20(%rbp), %r11d
	movq %r11, -28(%rbp)
	movq $4294967292, %r10
	cmpq %r10, -28(%rbp)
	movq $0, -36(%rbp)
	setNE -36(%rbp)
	cmpq $0, -36(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -16(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -40(%rbp), %r11d
	shrl $2, %r11d
	movl %r11d, -40(%rbp)
	cmpl $1073741823, -40(%rbp)
	movl $0, -44(%rbp)
	setNE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movl _shiftcount.2(%rip), %r10d
	movl %r10d, -48(%rbp)
	movl $1000000, -52(%rbp)
	movl -52(%rbp), %r11d
	movl -48(%rbp), %ecx
	shrl %cl, %r11d
	movl %r11d, -52(%rbp)
	cmpl $31250, -52(%rbp)
	movl $0, -56(%rbp)
	setNE -56(%rbp)
	cmpl $0, -56(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movl _shiftcount.2(%rip), %r10d
	movl %r10d, -60(%rbp)
	movl $1000000, -64(%rbp)
	movl -64(%rbp), %r11d
	movl -60(%rbp), %ecx
	shll %cl, %r11d
	movl %r11d, -64(%rbp)
	cmpl $32000000, -64(%rbp)
	movl $0, -68(%rbp)
	setNE -68(%rbp)
	cmpl $0, -68(%rbp)
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
