	.file	"crt-test.c"                    # tells `as` that we are about to start a new logical file. string is the new file name.
	.text                                   # Tells `as` to assemble the following statements onto the end of the text subsection numbered subsection
	.globl	static_variable                 # makes the symbol visible to ld
	.data                                   # tells `as` to assemble the following statements onto the end of the data subsection numbered subsection
	.align 4                                # Pad the location counter (in the current subsection) to a particular storage boundary
	.type	static_variable, @object        # This sets the type of symbol name to be either a function symbol or an object symbol
	.size	static_variable, 4              # This directive sets the size associated with a symbol name
static_variable:                            # A label is written as a symbol immediately followed by a colon `:'. The symbol then represents the current value of the active location counter
	.long	5                               # .long is the same as `.int'. Expect zero or more expressions, of any section, separated by commas. For each expression, emit a number that, at run time, is the value of that expression.
	.text
	.globl	f
	.type	f, @function
f:
.LFB0:                                      # Label of Function Begining
	.cfi_startproc                          # CFA 代表“规范帧地址”
                                            # .cfi_startproc is used at the beginning of each function that should have an entry in .eh_frame.
	pushq	%rbp                            # 保存 rbp                      # rbp - 8
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp                      # rbp指向栈顶
	.cfi_def_cfa_register 6
	pushq	%r13                                                            # rbp - 16
	pushq	%r12                                                            # rbp - 24
	pushq	%rbx                                                            # rbp - 32
	subq	$24, %rsp                       # 栈顶下移24字节
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movl	$1, %r12d                       # register变量：i1
	movl	$10, %r13d                      # register变量：i10
	movl	$110, %ebx                      # register变量：c1
	movl	$1, a_very_long_name_to_see_how_long_they_can_be(%rip)  # rip相对寻址。外部全局变量的offset要在链接的时候确定
	movl	%r13d, %edx                     # 第三个参数：rdx = i10
	movl	%r12d, %esi                     # 第二个参数：rsi = i1
	movl	$10, %edi                       # 第一个参数：rdi = 10
	movl	$0, %eax                        # 初始化返回值：rax为0
	call	func_ret_int
	movl	$0, %eax                        # 初始化返回值：rax为0
	call	func_ret_double                 # 无参数调用
	movq	%xmm0, %rax                     # 返回值：浮点数使用xmm0返回
	movq	%rax, -40(%rbp)                 # 返回值保存到栈上（因为栈顶下移了24字节，所以有空闲的空间）
	movq	%rbx, %rdi                      # 第一个参数：rdi = c1
	movl	$0, %eax                        # 初始化返回值：rax为0
	call	func_ret_char_ptr
	nop
	addq	$24, %rsp                       # 栈顶上移24字节
	popq	%rbx                            # 弹出栈中保存的寄存器值
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:                                      # Label of Function Ending
	.size	f, .-f                          # The special symbol `.' refers to the current address that `as` is assembling into.
	.globl	func_ret_int
	.type	func_ret_int, @function
func_ret_int:
.LFB1:
	.cfi_startproc                          # vvvvvvvvvvvv
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16                      # 这一段跟函数f完全一样
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6                 # ^^^^^^^^^^^^
	movl	%edi, -20(%rbp)                 # 保存第一个参数：a     直接使用栈顶之下的空间
	movl	%esi, -24(%rbp)                 # 保存第二个参数: b
	movl	-24(%rbp), %eax                 # eax = b
	subl	$6, %eax                        # eax = b - 6
	movl	%eax, -4(%rbp)                  # 保存d 
	movl	-20(%rbp), %ecx                 # 读：ecx = a
	movl	-24(%rbp), %eax                 # 读：eax = b
	addl	%ecx, %eax                      # eax = b + a
	addl	%edx, %eax                      # eax = b + a + 第三个参数c。eax刚好作为返回值
	popq	%rbp                            # 弹出栈中保存的寄存器值
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	func_ret_int, .-func_ret_int
	.globl	func_ret_double
	.type	func_ret_double, @function
func_ret_double:
.LFB2:
	.cfi_startproc                          # vvvvvvvvvvvv
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16                      # 这一段跟函数f完全一样
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6                 # ^^^^^^^^^^^^
	movsd	.LC0(%rip), %xmm0               # xmm0 = 3.14
	movq	%xmm0, %rax                     # 这里不知道折腾啥呢
	movq	%rax, %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	func_ret_double, .-func_ret_double
	.globl	func_ret_char_ptr
	.type	func_ret_char_ptr, @function
func_ret_char_ptr:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6                     # 这一段之前跟函数f完全一样
	movq	%rdi, -8(%rbp)                      # 保存第一个参数：cp
	movq	-8(%rbp), %rax                      # rax = cp
	addq	$1, %rax                            # rax = cp + 1。同时作为返回值
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	func_ret_char_ptr, .-func_ret_char_ptr
	.section	.rodata                         # 开始.rodata段
	.align 8                                    # 8字节对齐
.LC0:
	.long	1374389535                          # 浮点数3.14的低4字节
	.long	1074339512                          # 浮点数3.14的高4字节
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
