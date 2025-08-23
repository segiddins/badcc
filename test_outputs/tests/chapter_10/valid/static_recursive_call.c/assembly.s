	.bss
_count.3:
	.zero 4

	.globl _print_alphabet
	.text
_print_alphabet:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movl _count.3(%rip), %r10d
	movl %r10d, -12(%rbp)
	addl $65, -12(%rbp)
	movl -12(%rbp), %edi
	call _putchar
	movl %eax, -16(%rbp)
	movl _count.3(%rip), %r10d
	movl %r10d, -20(%rbp)
	addl $1, -20(%rbp)
	movl -20(%rbp), %r10d
	movl %r10d, _count.3(%rip)
	cmpl $26, _count.3(%rip)
	movl $0, -24(%rbp)
	setL -24(%rbp)
	cmpl $0, -24(%rbp)
	jE Lprint_alphabet.0.true
	call _print_alphabet
	movl %eax, -28(%rbp)
	jmp Lprint_alphabet.0.end
	Lprint_alphabet.0.true:
	Lprint_alphabet.0.end:
	movl _count.3(%rip), %eax
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
	subq $16, %rsp
	call _print_alphabet
	movl %eax, -12(%rbp)
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
