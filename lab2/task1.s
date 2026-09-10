.section .bsss
.global ram
.lcomm ram, 256      # reserve 256 bytes of ram

.section .text
.global fill_ram    # make function visible to print_ram.c

fill_ram:

    movb $0xFF, ram+0x50
    movb $0xFF, ram+0x51
    movb $0xFF, ram+0x52
    movb $0xFF, ram+0x53
    movb $0xFF, ram+0x54
    movb $0xFF, ram+0x55
    movb $0xFF, ram+0x56
    movb $0xFF, ram+0x57
    movb $0xFF, ram+0x58

    ret              # return control back to print_ram.c

.section .note.GNU-stack,"",@progbits
