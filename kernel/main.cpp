#include "vga.h"

extern "C" void kernel_main() {
    terminal_initialize();
    terminal_writestring("Welcome to Interval\n");
    while (true) {}
}