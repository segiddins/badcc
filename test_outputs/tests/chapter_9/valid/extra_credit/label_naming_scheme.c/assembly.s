	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	Lmain._label:
	Lmain.label_:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _main_
	.text
_main_:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	Lmain_.label:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl __main
	.text
__main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	L_main.label:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
