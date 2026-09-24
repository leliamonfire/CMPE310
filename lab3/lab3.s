.section .data
prompt1: .ascii "Enter first string: \n"
len1 = . - prompt1
prompt2: .ascii "Enter second string: \n"
len2 = . - prompt2

.section .bss
.comm input1, 256
.comm input2, 256

.section .text
.global hamming_distance

hamming_distance:

    # use stack to expose answer to print_distance.c for printing
    push %rbp
    mov %rsp, %rbp
    push %rbx           # save caller's rbx (we use it below)
    push %r15           # save caller's r15 (we use it below)

    #
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

    mov %rax, %r8      # copy input1 length

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

    mov %rax, %r9     # copy input2 length

    # compare input lengths
    mov %r8, %r10
    cmp %r9, %r10
    jbe min_first
    mov %r9, %r10

    min_first:
        xor %r15, %r15 # total distance so far is 0
        xor %rbx, %rbx # index for loop i = 0

    compare_loop:
        cmp %r10, %rbx
        jge compare_done
        movzbl input1(%rbx), %eax # from textbook, grabs single byte for comparison
        movzbl input2(%rbx), %ecx
        xor %ecx, %eax

        # count 0 byte
        xor %edx, %edx # bit count is 0
        mov $8, %r11d

    low_count_loop:
        test $1, %al # AND to check for lowest bit
        jz no_bit
        inc %edx
    no_bit:
        shr $1, %al # shift right so next bit becomes lowest bit
        dec %r11d
        jnz low_count_loop

    add %rdx, %r15

    inc %rbx
    jmp compare_loop

    compare_done:
        mov %r15, %rax        # return value goes in rax for C printing

        pop %r15
        pop %rbx
        pop %rbp
        ret
