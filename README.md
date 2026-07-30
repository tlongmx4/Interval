# Interval

A small x86 kernel written from scratch. Bootloader, protected mode, and everything above it.

![Interval booting](docs/boot.png)

## What works

- **Stage 1 bootloader** (512 bytes) -- saves the BIOS boot drive, reads stage 2
    off disk with `int 13h`, hands off to it
- **Stage 2** -- sets up segments and a stack, enables the A20 line, loads the
    kernel to `0x10000`, builds a flat GDT, enters the 32-bit protected mode
- **C++ kernel** -- linked as a flat binary at `0x10000`, entered from a small
    assembly stub 
- **VGA text driver** -- writes directly to `0xB8000`; clearing, cursor tracking
    newline handling, 16 colors

## Building

Requires `nasm`, `qemu`, and an `i686-elf` cross toolchain:

```sh
brew install nasm qemu i686-elf-gcc
make run
```

`make clean` removes all build artifacts

## Layout

| Path | Purpose |
|---|---|
| `boot/` | Stage 1 and stage 2 -- real mode through protected mode |
| `kernel/` | Entry stub and C++ sources |
| `include/` | Headers |
| `linker.ld` | Memory layout -- kernel placed at `0x10000` |

## Next

- [ ] Scrolling instead of wrapping at the bottom of the screen
- [ ] Hardware cursor via ports `0x3D4'/`0x3D5'
- [ ] Zero `.bss` in the entry stub rather than relying on a zeroed disk image
- [ ] IDT and interrupt handling
- [ ] PS/2 keyboard driver
