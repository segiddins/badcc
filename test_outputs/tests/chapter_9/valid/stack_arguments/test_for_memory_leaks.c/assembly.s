	.globl _lots_of_args
_lots_of_args:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	movl %edi, -12(%rbp)
	movl %esi, -16(%rbp)
	movl %edx, -20(%rbp)
	movl %ecx, -24(%rbp)
	movl %r8d, -28(%rbp)
	movl %r9d, -32(%rbp)
	movl 16(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl 24(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl 32(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl 40(%rbp), %r10d
	movl %r10d, -48(%rbp)
	movl 48(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movl 56(%rbp), %r10d
	movl %r10d, -56(%rbp)
	movl 64(%rbp), %r10d
	movl %r10d, -60(%rbp)
	movl 72(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl 80(%rbp), %r10d
	movl %r10d, -68(%rbp)
	movl -56(%rbp), %r10d
	movl %r10d, -72(%rbp)
	movl -68(%rbp), %r10d
	addl %r10d, -72(%rbp)
	movl -72(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl $0, -12(%rbp)
	movl $0, -16(%rbp)
	Lloop.0.cond:
	cmpl $10000000, -16(%rbp)
	movl $0, -20(%rbp)
	setL -20(%rbp)
	cmpl $0, -20(%rbp)
	jE Lloop.0
	subq $8, %rsp
	movl $1, %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $5, %r8d
	movl $6, %r9d
	pushq $15
	pushq $14
	pushq $13
	movl -12(%rbp), %eax
	pushq %rax
	pushq $11
	pushq $10
	pushq $9
	pushq $8
	pushq $7
	call _lots_of_args
	addq $80, %rsp
	movl %eax, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, -12(%rbp)
	Lloop.0.start:
	movl -16(%rbp), %r10d
	movl %r10d, -28(%rbp)
	addl $1, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -16(%rbp)
	jmp Lloop.0.cond
	Lloop.0:
	cmpl $150000000, -12(%rbp)
	movl $0, -32(%rbp)
	setE -32(%rbp)
	movl -32(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
