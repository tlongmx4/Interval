[org 0x7c00]

        mov [boot_drive], dl
        xor ax, ax
        mov ds, ax
        mov es, ax
        cld

        mov ah, 02h
        mov al, 8
        mov ch, 0
        mov cl, 2
        mov dh, 0
        mov dl, [boot_drive]
        mov bx, 7E00h

        int 13h
        jc read_error

        jmp 0x7E00

read_error:
        mov ah, 0x0e
        mov al, 'E'
        int 0x10
        jmp $

boot_drive: db 0

times 510-($-$$) db 0
dw 0xaa55