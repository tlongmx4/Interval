extern "C" void kernel_main() {
    volatile char* vga = (char*)0xb8000;
    const char* msg = "Interval is running";
    for (int i = 0; msg[i]; i++) {
       vga[i * 2] = msg[i];
        vga[i * 2 + 1] = 0x0F;
    }
    while (true) {}
}