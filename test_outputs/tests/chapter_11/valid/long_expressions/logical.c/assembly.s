	.globl _not
	.text
_not:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, -16(%rbp)
	cmpq $0, -16(%rbp)
	movq $0, -24(%rbp)
	setE -24(%rbp)
	movq -24(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _if_cond
	.text
_if_cond:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq %rdi, -16(%rbp)
	cmpq $0, -16(%rbp)
	jE Lif_cond.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lif_cond.0.end
	Lif_cond.0.true:
	Lif_cond.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _and
	.text
_and:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, -16(%rbp)
	movl %esi, -20(%rbp)
	cmpq $0, -16(%rbp)
	jE Land.0.false
	movl -20(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -28(%rbp)
	cmpq $0, -28(%rbp)
	jE Land.0.false
	movl $1, -32(%rbp)
	jmp Land.0.end
	Land.0.false:
	movl $0, -32(%rbp)
	Land.0.end:
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _or
	.text
_or:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl %edi, -12(%rbp)
	movq %rsi, -20(%rbp)
	movl -12(%rbp), %r11d
	movslq %r11d, %r10
	movq %r10, -28(%rbp)
	cmpq $0, -28(%rbp)
	jNE Lor.0.true
	cmpq $0, -20(%rbp)
	jNE Lor.0.true
	movl $0, -32(%rbp)
	jmp Lor.0.end
	Lor.0.true:
	movl $1, -32(%rbp)
	Lor.0.end:
	movl -32(%rbp), %eax
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
	movq $1152921504606846976, %r10
	movq %r10, -16(%rbp)
	movq $0, -24(%rbp)
	movq -16(%rbp), %rdi
	call _not
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
	movq -24(%rbp), %rdi
	call _not
	movl %eax, -32(%rbp)
	cmpl $0, -32(%rbp)
	movl $0, -36(%rbp)
	setE -36(%rbp)
	cmpl $0, -36(%rbp)
	jE Lmain.1.true
	movl $2, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.1.end
	Lmain.1.true:
	Lmain.1.end:
	movq -16(%rbp), %rdi
	call _if_cond
	movl %eax, -40(%rbp)
	cmpl $0, -40(%rbp)
	movl $0, -44(%rbp)
	setE -44(%rbp)
	cmpl $0, -44(%rbp)
	jE Lmain.2.true
	movl $3, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.2.end
	Lmain.2.true:
	Lmain.2.end:
	movq -24(%rbp), %rdi
	call _if_cond
	movl %eax, -48(%rbp)
	cmpl $0, -48(%rbp)
	jE Lmain.3.true
	movl $4, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.3.end
	Lmain.3.true:
	Lmain.3.end:
	movq -24(%rbp), %rdi
	movl $1, %esi
	call _and
	movl %eax, -52(%rbp)
	cmpl $0, -52(%rbp)
	jE Lmain.4.true
	movl $5, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.4.end
	Lmain.4.true:
	Lmain.4.end:
	movl $1, %edi
	movq -16(%rbp), %rsi
	call _or
	movl %eax, -56(%rbp)
	cmpl $0, -56(%rbp)
	movl $0, -60(%rbp)
	setE -60(%rbp)
	cmpl $0, -60(%rbp)
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
