	.data
_a.1:
	.long 3
	.data
_a.3:
	.long 4
	.globl _foo
	.text
_foo:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _a.1(%rip), %r10d
	movl %r10d, -12(%rbp)
	movl -12(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, _a.1(%rip)
	movl _a.1(%rip), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _bar
	.text
_bar:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movl _a.3(%rip), %r10d
	movl %r10d, -12(%rbp)
	addl $1, -12(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, _a.3(%rip)
	movl _a.3(%rip), %eax
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
	subq $48, %rsp
	call _foo
	movl %eax, -12(%rbp)
	call _bar
	movl %eax, -16(%rbp)
	movl -12(%rbp), %r10d
	movl %r10d, -20(%rbp)
	movl -16(%rbp), %r10d
	addl %r10d, -20(%rbp)
	call _foo
	movl %eax, -24(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, -28(%rbp)
	movl -24(%rbp), %r10d
	addl %r10d, -28(%rbp)
	call _bar
	movl %eax, -32(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -32(%rbp), %r10d
	addl %r10d, -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
