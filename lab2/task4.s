.section .bsss
.global ram
.lcomm ram, 256

.section .text
.global fill_ram

fill_ram: 
          # sets bl to 1
          # increments to 10 (0A)
          # loads into ram+0x50

    mov $1, %bl

    inc_loop:
        incb %bl

        cmpb $10, %bl
        jne inc_loop

    movb %bl, ram+0x50

    ret

.section .note.GNU-stack,"",@progbits
