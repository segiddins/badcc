	.globl _glob
	.data
_glob:
	.long 5000
	.globl _main
	.text
_main:
	pushq %rbp
	movq %rsp, %rbp
	subq $256, %rsp
	movl _glob(%rip), %r11d
	movq %r11, -16(%rbp)
	movq -16(%rbp), %r10
	movq %r10, -24(%rbp)
	movl _glob(%rip), %r10d
	movl %r10d, -28(%rbp)
	subl $4999, -28(%rbp)
	movl -28(%rbp), %r10d
	movl %r10d, -32(%rbp)
	movl -32(%rbp), %r10d
	movl %r10d, -36(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -40(%rbp)
	movl -36(%rbp), %r10d
	addl %r10d, -40(%rbp)
	movl -40(%rbp), %r10d
	movl %r10d, -44(%rbp)
	movl $2, -48(%rbp)
	movl -36(%rbp), %r10d
	addl %r10d, -48(%rbp)
	movl -48(%rbp), %r10d
	movl %r10d, -52(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -56(%rbp)
	movl -56(%rbp), %r11d
	imull -44(%rbp), %r11d
	movl %r11d, -56(%rbp)
	movl -56(%rbp), %r10d
	movl %r10d, -60(%rbp)
	movl $6, -64(%rbp)
	movl -36(%rbp), %r10d
	subl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	movl %r10d, -68(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -72(%rbp)
	movl -72(%rbp), %r11d
	imull -52(%rbp), %r11d
	movl %r11d, -72(%rbp)
	movl -72(%rbp), %r10d
	movl %r10d, -76(%rbp)
	movl -36(%rbp), %r10d
	movl %r10d, -80(%rbp)
	addl $6, -80(%rbp)
	movl -80(%rbp), %r10d
	movl %r10d, -84(%rbp)
	movl -44(%rbp), %r10d
	movl %r10d, -88(%rbp)
	movl -88(%rbp), %r11d
	imull $4, %r11d
	movl %r11d, -88(%rbp)
	movl -88(%rbp), %r10d
	movl %r10d, -92(%rbp)
	movl -52(%rbp), %r10d
	movl %r10d, -96(%rbp)
	movl -96(%rbp), %r11d
	imull -52(%rbp), %r11d
	movl %r11d, -96(%rbp)
	movl -96(%rbp), %r10d
	movl %r10d, -100(%rbp)
	movl -60(%rbp), %r10d
	movl %r10d, -104(%rbp)
	movl -76(%rbp), %r10d
	addl %r10d, -104(%rbp)
	movl -104(%rbp), %r10d
	movl %r10d, -108(%rbp)
	movl $16, -112(%rbp)
	movl -68(%rbp), %r10d
	subl %r10d, -112(%rbp)
	movl -112(%rbp), %r10d
	movl %r10d, -116(%rbp)
	movl -76(%rbp), %r10d
	movl %r10d, -120(%rbp)
	movl -76(%rbp), %r10d
	addl %r10d, -120(%rbp)
	movl -120(%rbp), %r10d
	movl %r10d, -124(%rbp)
	subq $8, %rsp
	movl -36(%rbp), %edi
	movl -44(%rbp), %esi
	movl -52(%rbp), %edx
	movl -60(%rbp), %ecx
	movl -68(%rbp), %r8d
	movl -76(%rbp), %r9d
	pushq $1
	movl -124(%rbp), %eax
	pushq %rax
	movl -116(%rbp), %eax
	pushq %rax
	movl -108(%rbp), %eax
	pushq %rax
	movl -100(%rbp), %eax
	pushq %rax
	movl -92(%rbp), %eax
	pushq %rax
	movl -84(%rbp), %eax
	pushq %rax
	call _check_12_ints
	addq $64, %rsp
	movl %eax, -128(%rbp)
	movl _glob(%rip), %r10d
	movl %r10d, -132(%rbp)
	subl $4987, -132(%rbp)
	movl -132(%rbp), %r10d
	movl %r10d, -136(%rbp)
	movl -136(%rbp), %r10d
	movl %r10d, -140(%rbp)
	movl -140(%rbp), %r10d
	movl %r10d, -144(%rbp)
	addl $1, -144(%rbp)
	movl -144(%rbp), %r10d
	movl %r10d, -148(%rbp)
	movl $28, -152(%rbp)
	movl -140(%rbp), %r10d
	subl %r10d, -152(%rbp)
	movl -152(%rbp), %r10d
	movl %r10d, -156(%rbp)
	movl -148(%rbp), %r10d
	movl %r10d, -160(%rbp)
	addl $2, -160(%rbp)
	movl -160(%rbp), %r10d
	movl %r10d, -164(%rbp)
	movl $4, -168(%rbp)
	movl -140(%rbp), %r10d
	addl %r10d, -168(%rbp)
	movl -168(%rbp), %r10d
	movl %r10d, -172(%rbp)
	movl $32, -176(%rbp)
	movl -148(%rbp), %r10d
	subl %r10d, -176(%rbp)
	movl -176(%rbp), %r10d
	movl %r10d, -180(%rbp)
	movl $35, -184(%rbp)
	movl -164(%rbp), %r10d
	subl %r10d, -184(%rbp)
	movl -184(%rbp), %r10d
	movl %r10d, -188(%rbp)
	movl -156(%rbp), %r10d
	movl %r10d, -192(%rbp)
	addl $5, -192(%rbp)
	movl -192(%rbp), %r10d
	movl %r10d, -196(%rbp)
	movl -140(%rbp), %r10d
	movl %r10d, -200(%rbp)
	movl -200(%rbp), %r11d
	imull $2, %r11d
	movl %r11d, -200(%rbp)
	movl -200(%rbp), %r10d
	movl %r10d, -204(%rbp)
	subl $5, -204(%rbp)
	movl -204(%rbp), %r10d
	movl %r10d, -208(%rbp)
	movl -156(%rbp), %r10d
	movl %r10d, -212(%rbp)
	addl $7, -212(%rbp)
	movl -212(%rbp), %r10d
	movl %r10d, -216(%rbp)
	movl $6, -220(%rbp)
	movl -172(%rbp), %r10d
	addl %r10d, -220(%rbp)
	movl -220(%rbp), %r10d
	movl %r10d, -224(%rbp)
	movl -140(%rbp), %r10d
	movl %r10d, -228(%rbp)
	addl $11, -228(%rbp)
	movl -228(%rbp), %r10d
	movl %r10d, -232(%rbp)
	subq $8, %rsp
	movl -140(%rbp), %edi
	movl -148(%rbp), %esi
	movl -156(%rbp), %edx
	movl -164(%rbp), %ecx
	movl -172(%rbp), %r8d
	movl -180(%rbp), %r9d
	pushq $13
	movl -232(%rbp), %eax
	pushq %rax
	movl -224(%rbp), %eax
	pushq %rax
	movl -216(%rbp), %eax
	pushq %rax
	movl -208(%rbp), %eax
	pushq %rax
	movl -196(%rbp), %eax
	pushq %rax
	movl -188(%rbp), %eax
	pushq %rax
	call _check_12_ints
	addq $64, %rsp
	movl %eax, -236(%rbp)
	cmpq $5000, -24(%rbp)
	movq $0, -244(%rbp)
	setNE -244(%rbp)
	cmpq $0, -244(%rbp)
	jE Lmain.0.true
	movl $1, -248(%rbp)
	negl -248(%rbp)
	movl -248(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lmain.0.end
	Lmain.0.true:
	Lmain.0.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	.globl _check_12_ints
	.text
_check_12_ints:
	pushq %rbp
	movq %rsp, %rbp
	subq $160, %rsp
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
	movl $0, -64(%rbp)
	movl -60(%rbp), %r10d
	movl %r10d, -68(%rbp)
	addl $0, -68(%rbp)
	movl -68(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -12(%rbp)
	movl $0, -72(%rbp)
	setNE -72(%rbp)
	cmpl $0, -72(%rbp)
	jE Lcheck_12_ints.0.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.0.end
	Lcheck_12_ints.0.true:
	Lcheck_12_ints.0.end:
	movl -60(%rbp), %r10d
	movl %r10d, -76(%rbp)
	addl $1, -76(%rbp)
	movl -76(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -16(%rbp)
	movl $0, -80(%rbp)
	setNE -80(%rbp)
	cmpl $0, -80(%rbp)
	jE Lcheck_12_ints.1.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.1.end
	Lcheck_12_ints.1.true:
	Lcheck_12_ints.1.end:
	movl -60(%rbp), %r10d
	movl %r10d, -84(%rbp)
	addl $2, -84(%rbp)
	movl -84(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -20(%rbp)
	movl $0, -88(%rbp)
	setNE -88(%rbp)
	cmpl $0, -88(%rbp)
	jE Lcheck_12_ints.2.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.2.end
	Lcheck_12_ints.2.true:
	Lcheck_12_ints.2.end:
	movl -60(%rbp), %r10d
	movl %r10d, -92(%rbp)
	addl $3, -92(%rbp)
	movl -92(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -24(%rbp)
	movl $0, -96(%rbp)
	setNE -96(%rbp)
	cmpl $0, -96(%rbp)
	jE Lcheck_12_ints.3.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.3.end
	Lcheck_12_ints.3.true:
	Lcheck_12_ints.3.end:
	movl -60(%rbp), %r10d
	movl %r10d, -100(%rbp)
	addl $4, -100(%rbp)
	movl -100(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -28(%rbp)
	movl $0, -104(%rbp)
	setNE -104(%rbp)
	cmpl $0, -104(%rbp)
	jE Lcheck_12_ints.4.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.4.end
	Lcheck_12_ints.4.true:
	Lcheck_12_ints.4.end:
	movl -60(%rbp), %r10d
	movl %r10d, -108(%rbp)
	addl $5, -108(%rbp)
	movl -108(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -32(%rbp)
	movl $0, -112(%rbp)
	setNE -112(%rbp)
	cmpl $0, -112(%rbp)
	jE Lcheck_12_ints.5.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.5.end
	Lcheck_12_ints.5.true:
	Lcheck_12_ints.5.end:
	movl -60(%rbp), %r10d
	movl %r10d, -116(%rbp)
	addl $6, -116(%rbp)
	movl -116(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -36(%rbp)
	movl $0, -120(%rbp)
	setNE -120(%rbp)
	cmpl $0, -120(%rbp)
	jE Lcheck_12_ints.6.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.6.end
	Lcheck_12_ints.6.true:
	Lcheck_12_ints.6.end:
	movl -60(%rbp), %r10d
	movl %r10d, -124(%rbp)
	addl $7, -124(%rbp)
	movl -124(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -40(%rbp)
	movl $0, -128(%rbp)
	setNE -128(%rbp)
	cmpl $0, -128(%rbp)
	jE Lcheck_12_ints.7.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.7.end
	Lcheck_12_ints.7.true:
	Lcheck_12_ints.7.end:
	movl -60(%rbp), %r10d
	movl %r10d, -132(%rbp)
	addl $8, -132(%rbp)
	movl -132(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -44(%rbp)
	movl $0, -136(%rbp)
	setNE -136(%rbp)
	cmpl $0, -136(%rbp)
	jE Lcheck_12_ints.8.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.8.end
	Lcheck_12_ints.8.true:
	Lcheck_12_ints.8.end:
	movl -60(%rbp), %r10d
	movl %r10d, -140(%rbp)
	addl $9, -140(%rbp)
	movl -140(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -48(%rbp)
	movl $0, -144(%rbp)
	setNE -144(%rbp)
	cmpl $0, -144(%rbp)
	jE Lcheck_12_ints.9.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.9.end
	Lcheck_12_ints.9.true:
	Lcheck_12_ints.9.end:
	movl -60(%rbp), %r10d
	movl %r10d, -148(%rbp)
	addl $10, -148(%rbp)
	movl -148(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -52(%rbp)
	movl $0, -152(%rbp)
	setNE -152(%rbp)
	cmpl $0, -152(%rbp)
	jE Lcheck_12_ints.10.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.10.end
	Lcheck_12_ints.10.true:
	Lcheck_12_ints.10.end:
	movl -60(%rbp), %r10d
	movl %r10d, -156(%rbp)
	addl $11, -156(%rbp)
	movl -156(%rbp), %r10d
	movl %r10d, -64(%rbp)
	movl -64(%rbp), %r10d
	cmpl %r10d, -56(%rbp)
	movl $0, -160(%rbp)
	setNE -160(%rbp)
	cmpl $0, -160(%rbp)
	jE Lcheck_12_ints.11.true
	movl -64(%rbp), %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp Lcheck_12_ints.11.end
	Lcheck_12_ints.11.true:
	Lcheck_12_ints.11.end:
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
	movl $0, %eax
	movq %rbp, %rsp
	popq %rbp
	ret
