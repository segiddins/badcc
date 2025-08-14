	.bss
_a.1:
	.zero 4
	.bss
_a.10:
	.zero 4
	.bss
_a.11:
	.zero 4
	.bss
_a.12:
	.zero 4
	.bss
_a.13:
	.zero 4
	.bss
_a.15:
	.zero 4
	.bss
_a.6:
	.zero 4
	.bss
_a.7:
	.zero 4
	.bss
_a.8:
	.zero 4
	.bss
_a.9:
	.zero 4
	.bss
_result.2:
	.zero 4
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movl $1, -12(%rbp)
	movl $2, -16(%rbp)
	movl $2, -20(%rbp)
	movl $20, -24(%rbp)
	movl -24(%rbp), %r10d
	movl %r10d, _result.2(%rip)
	movl $5, _a.15(%rip)
	movl _result.2(%rip), %r10d
	movl %r10d, -28(%rbp)
	movl _a.15(%rip), %r10d
	addl %r10d, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, _result.2(%rip)
	movl _result.2(%rip), %r10d
	movl %r10d, -32(%rbp)
	movl -20(%rbp), %r10d
	addl %r10d, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, _result.2(%rip)
	movl _result.2(%rip), %r10d
	movl %r10d, -36(%rbp)
	movl -12(%rbp), %r10d
	addl %r10d, -36(%rbp)
	movl -36(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
