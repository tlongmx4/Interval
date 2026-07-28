[org 0x7c00]

	xor ax, ax
	mov ds, ax
	mov es, ax
	cld

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

message: db 'Hello', 0

times 510-($-$$) db 0
dw 0xaa55
