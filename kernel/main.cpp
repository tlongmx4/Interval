#include "vga.h"
#include "idt.h"

extern "C" void kernel_main() {
    terminal_initialize();
    terminal_writestring("Welcome to Interval\n");

    idt_init();
    terminal_writestring("IDT installed\n");

    asm volatile("int $3");

    while (true) {}
}