.section .data
prompt1: .ascii "Enter first string: \n"
len1 = . - prompt1
prompt2: .ascii "Enter second string: \n"
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
    mov $256,   %rdx    # max length 256 bytes
    syscall

    mov (%rdi), %ecx      # copy input1 length

    mov $1,     %rax        # write
    mov $1,     %rdi        # stdout
    mov $prompt2,   %rsi    # buf
    mov $len2,   %rdx       # len
    syscall

    mov $0,     %rax    # read
    mov $0,     %rdi    # stdin
    mov $input2, %rsi   # load second input
    mov $256,   %rdx    # max legnth 256 bytes
    syscall

    mov (%rax), %edx      # copy input2 length

    mov $input1, %eax   # copy input1 to %eax
    mov $input2, %ebx   # copy input2 to %ebx

    cmp %ecx, %edx
    jae input1_larger
    jbe input2_larger

    input1_larger:
        xor %ebx, %eax
        mov %eax, %edx

    input2_larger:
        xor %eax, %ebx
        mov %ebx, %edx

    mov $1,     %rax    # write
    mov $1,     %rdi    # stdout
    mov (%edx), %rsi      # copy hamming distance to buffer
    mov $256,   %rdx    # length 256 bytes
    #syscall

    mov $60,    %rax    # exit
    mov $0,     %rdi    # status
    syscall
