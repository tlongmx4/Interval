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

    mov [boot_drive], dl

    mov si, msg_stage2
    call print_string

    ; ---- load kernel to 0x10000 ----
    mov ah, 0x02
    mov al, 16              ; 16 sectors
    mov ch, 0
    mov cl, 10              ; kernel starts at sector 10
    mov dh, 0
    mov dl, [boot_drive]

    mov bx, 0x1000
    mov es, bx
    xor bx, bx              ; es:bx = 0x1000:0000 = 0x10000

    int 0x13
    jc disk_error

    xor ax, ax
    mov es, ax              ; put es back to 0

    cli

    in al, 0x92
    or al, 2
    and al, 0xFE
    out 0x92, al

    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp CODE_SEG:protected_start

disk_error:
    mov si, msg_disk_error
    call print_string
    cli
    hlt

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

    jmp 0x10000

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

boot_drive     db 0
msg_stage2     db "Successfully loaded Stage 2!", 0x0D, 0x0A, 0
msg_disk_error db "Kernel load failed!", 0x0D, 0x0A, 0