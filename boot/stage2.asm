[org 0x7e00]
bits 16

stage2_start:

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, 0x7C00
    cld

    mov si, msg_stage2
    call print_string

    cli

    in al, 0x92
    or al, 2
    out 0x92, al

    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp CODE_SEG:protected_start

print_string:
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .loop
.done:
    ret


bits 32
protected_start:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0x90000

    mov esi, msg_protected
    mov edi, 0xB8000
    mov ah, 0x0F

.pm_print_loop:
    lodsb
    or al, al
    jz .halt
    mov [edi], ax
    add edi, 2
    jmp .pm_print_loop

.halt:
    hlt
    jmp .halt

align 4
gdt_start:

gdt_null:
    dd 0x0
    dd 0x0

gdt_code:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_data:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

msg_stage2    db "Successfully loaded Stage 2!", 0x0D, 0x0A, 0
msg_protected db "Successfully running in 32-bit Protected Mode!", 0

times 4096-($-$$) db 0