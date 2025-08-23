	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $100, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r11d
	sall $22, %r11d
	movl %r11d, -12(%rbp)
	cmpl $419430400, -12(%rbp)
	movl $0, -16(%rbp)
	setNE -16(%rbp)
	cmpl $0, -16(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl -12(%rbp), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r11d
	sarl $4, %r11d
	movl %r11d, -12(%rbp)
	cmpl $26214400, -12(%rbp)
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
	cmpl $26214400, -12(%rbp)
	movl $0, -24(%rbp)
	setNE -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq $12345, -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -32(%rbp)
	movq -32(%rbp), %r11
	salq $33, %r11
	movq %r11, -32(%rbp)
	movq $106042742538240, %r10
	cmpq %r10, -32(%rbp)
	movq $0, -40(%rbp)
	setNE -40(%rbp)
	cmpq $0, -40(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq -32(%rbp), %r10
	movq %r10, -48(%rbp)
	negq -48(%rbp)
	movq -48(%rbp), %r10
	movq %r10, -32(%rbp)
	movq -32(%rbp), %r10
	movq %r10, -32(%rbp)
	movq -32(%rbp), %r11
	sarq $10, %r11
	movq %r11, -32(%rbp)
	movq $103557365760, %r10
	movq %r10, -56(%rbp)
	negq -56(%rbp)
	movq -56(%rbp), %r10
	cmpq %r10, -32(%rbp)
	movq $0, -64(%rbp)
	setNE -64(%rbp)
	cmpq $0, -64(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
