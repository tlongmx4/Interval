# Interval

A small x86 kernel written from scratch. Bootloader, protected mode, and everything above it.

![Interval booting](docs/boot.png)

**Status:** two-stage boot — the boot sector reads stage 2 off disk and jumps to it. Next up: protected mode and the handoff to C++.
