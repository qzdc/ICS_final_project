	.file	"test.c"
	.text
	.section	.rodata
.LC0:
	.string	"%15s"
.LC1:
	.string	"Hello %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp				#开辟栈帧.大小为32
	movq	%fs:40, %rax			#得到金丝雀
	movq	%rax, -8(%rbp)			#设置金丝雀
	xorl	%eax, %eax				#中间变量清零
	leaq	-32(%rbp), %rax			#得到变量s
	movq	%rax, %rsi				#设置第二个参数
	leaq	.LC0(%rip), %rax		#得到输入格式控制字符串
	movq	%rax, %rdi				#设置第一个参数
	movl	$0, %eax				#中间变量清零
	call	__isoc99_scanf@PLT		#调用输入函数
	leaq	-32(%rbp), %rax			#变量s
	movq	%rax, %rsi				#设置第二个参数
	leaq	.LC1(%rip), %rax		#得到输出格式控制字符串
	movq	%rax, %rdi				#设置第一个参数
	movl	$0, %eax				#中间变量清零
	call	printf@PLT				#调用输出函数
	movl	$0, %eax				#返回值清零
	movq	-8(%rbp), %rdx			#得到执行后的待检验的金丝雀
	subq	%fs:40, %rdx			#得到金丝雀
	je	.L3							#比较是否溢出
	call	__stack_chk_fail@PLT	#溢出，报错
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret								#不溢出，正常执行返回操作
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
