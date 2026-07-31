#include "vga.h"
#include <stdint.h>

#include "../../include/vga.h"

struct registers {
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t int_no, err_code;
    uint32_t eip, cs, eflags;
};

extern "C" void exception_handler(registers* regs) {
    (void)regs;
    terminal_writestring("EXCEPTION\n");
    for (;;) asm volatile("cli; hlt");
}