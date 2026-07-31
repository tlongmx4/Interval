bits 32
global _start
extern kernel_main
extern __bss_start
extern __bss_end

_start:
    cld
    mov edi, __bss_start
    mov ecx, __bss_end
    sub ecx, edi
    xor eax, eax
    rep stosb
    
    call kernel_main
    jmp $