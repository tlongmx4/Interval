#include "idt.h"
#include <stdint.h>

extern "C" uint32_t isr_stub_table[];

struct idt_entry {
    uint16_t offset_low;
    uint16_t selector;
    uint8_t zero;
    uint8_t type_attr;
    uint16_t offset_high;
} __attribute__((packed));

struct idt_ptr {
    uint16_t limit;
    uint32_t base;
} __attribute__((packed));

static idt_entry idt[48];
static idt_ptr idtp;

static void set_gate(int n, uint32_t handler) {
    idt[n].offset_low = handler & 0xFFFF;
    idt[n].selector = 0x08;
    idt[n].zero = 0;
    idt[n].type_attr = 0x8E;
    idt[n].offset_high = (handler >> 16) & 0xFFFF;
}

void idt_init() {
    for (int i = 0; i < 48; i++)
        set_gate(i, isr_stub_table[i]);

    idtp.limit = sizeof(idt) - 1;
    idtp.base = (uint32_t)&idt;

    asm volatile("lidt %0" : : "m"(idtp));
}
