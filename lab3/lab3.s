.section .data
prompt1: .asciz "Enter first string: \n"
len1 = . - prompt1
prompt2: .asciz "Enter second string: \n"
len2 = . - prompt2

.section .bss
.comm input1, 256
.comm input2, 256

.section .text
.global _start

_start:
    mov $1,         %rax    # write
    mov $1,         %rdi    # stdout
    mov $prompt1,   %rsi    # buf
    mov $len1,      %rdx    # len
    syscall

    mov $0,     %rax    # read
    mov $0,     %rdi    # stdin
    mov $input1, %rsi   # load first input
    mov $256,   %rdx    # length 256 bytes
    syscall

    mov $1,     %rax        # write
    mov $1,     %rdi        # stdout
    mov $prompt2,   %rsi    # buf
    mov $len2,   %rdx       # len
    syscall

    mov $0,     %rax    # read
    mov $0,     %rdi    # stdin
    mov $input2, %rsi   # load second input
    mov $256,   %rdx    # legnth 256 bytes
    syscall

    mov $input1, %eax
    mov $input2, %ebx

    xorl %eax, %ebx

    mov $1,     %rax
    mov $1,     %rdi
    mov (%ebx), %rsi
    mov $256,   %rdx
    #syscall

    mov $60,    %rax    # exit
    mov $0,     %rdi    # status
    syscall
