.section .data
prompt: .asciz "Enter a string: \n"
len = . - prompt

.section .bss
.comm input, 256

.section .text
.global _start

_start:
    mov $1,     %rax    # write
    mov $1,     %rdi    # stdout
    mov $prompt,   %rsi    # buf
    mov $len,   %rdx    # len
    syscall

    mov $0,     %rax
    mov $0,     %rdi
    mov $input, %rsi
    mov $256,   %rdx
    syscall

    mov $1,     %rax    # write
    mov $1,     %rdi    # stdout
    mov $input,   %rsi    # buf
    mov $256,   %rdx    # len
    syscall

    mov $60,    %rax    # exit
    mov $0,     %rdi    # status
    syscall

    