[org 0x7E00]

        mov si, message

print_loop:
        lodsb
        test al, al
        je done
        mov ah, 0x0e
        int 0x10
        jmp print_loop

done:
        jmp $

message: db 'Stage 2!', 0

times 512-($-$$) db 0