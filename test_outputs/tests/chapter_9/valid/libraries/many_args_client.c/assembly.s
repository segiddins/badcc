	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movl $4, %edi
	call _fib
	movl %eax, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -16(%rbp)
	movl $7, -20(%rbp)
	movl $6, %edi
	call _fib
	movl %eax, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -16(%rbp), %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $5, %r8d
	movl $6, %r9d
	movl -28(%rbp), %eax
	pushq %rax
	movl -20(%rbp), %eax
	pushq %rax
	call _multiply_many_args
	addq $16, %rsp
	movl %eax, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	cmpl $3, -16(%rbp)
	movl $0, -40(%rbp)
	setNE -40(%rbp)
	cmpl $0, -40(%rbp)
	jE Lmain.0.true
	movl $1, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	cmpl $589680, -36(%rbp)
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
	movl -36(%rbp), %eax
	cdq
	movl $256, %r10d
	idivl %r10d
	movl %edx, -48(%rbp)
	movl -16(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movl -48(%rbp), %r10d
	addl %r10d, -52(%rbp)
	movl -52(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
