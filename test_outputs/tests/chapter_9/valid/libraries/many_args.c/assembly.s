	.globl _fib
_fib:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl %edi, -12(%rbp)
	cmpl $0, -12(%rbp)
	movl $0, -16(%rbp)
	setE -16(%rbp)
	cmpl $0, -16(%rbp)
	jNE Lfib.1.true
	cmpl $1, -12(%rbp)
	movl $0, -20(%rbp)
	setE -20(%rbp)
	cmpl $0, -20(%rbp)
	jNE Lfib.1.true
	movl $0, -24(%rbp)
	jmp Lfib.1.end
	Lfib.1.true:
	movl $1, -24(%rbp)
	Lfib.1.end:
	cmpl $0, -24(%rbp)
	jE Lfib.0.true
	movl -12(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lfib.0.end
	Lfib.0.true:
	movl -12(%rbp), %r10d
	movl %r10d, -28(%rbp)
	subl $1, -28(%rbp)
	movl -28(%rbp), %edi
	call _fib
	movl %eax, -32(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -36(%rbp)
	subl $2, -36(%rbp)
	movl -36(%rbp), %edi
	call _fib
	movl %eax, -40(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -40(%rbp), %r10d
	addl %r10d, -44(%rbp)
	movl -44(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	Lfib.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _multiply_many_args
_multiply_many_args:
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
	movl -12(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl -44(%rbp), %r11d
	imull -16(%rbp), %r11d
	movl %r11d, -44(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -48(%rbp)
	movl -48(%rbp), %r11d
	imull -20(%rbp), %r11d
	movl %r11d, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movl -52(%rbp), %r11d
	imull -24(%rbp), %r11d
	movl %r11d, -52(%rbp)
	movl -52(%rbp), %r10d
	movl %r10d, -56(%rbp)
	movl -56(%rbp), %r11d
	imull -28(%rbp), %r11d
	movl %r11d, -56(%rbp)
	movl -56(%rbp), %r10d
	movl %r10d, -60(%rbp)
	movl -60(%rbp), %r11d
	imull -32(%rbp), %r11d
	movl %r11d, -60(%rbp)
	movl -36(%rbp), %edi
	call _fib
	movl %eax, -64(%rbp)
	movl -60(%rbp), %r10d
	movl %r10d, -68(%rbp)
	movl -68(%rbp), %r11d
	imull -64(%rbp), %r11d
	movl %r11d, -68(%rbp)
	movl -40(%rbp), %edi
	call _fib
	movl %eax, -72(%rbp)
	movl -68(%rbp), %r10d
	movl %r10d, -76(%rbp)
	movl -76(%rbp), %r11d
	imull -72(%rbp), %r11d
	movl %r11d, -76(%rbp)
	movl -76(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
