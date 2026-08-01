# Interval

A small x86 kernel written from scratch. Bootloader, protected mode, and everything above it.

![Interval booting](docs/boot.png)

## What works

- **Stage 1 bootloader** (512 bytes): saves the BIOS boot drive, reads stage 2
  off disk with `int 13h`, hands off to it
- **Stage 2**: sets up segments and a stack, enables the A20 line, loads the
  kernel to `0x10000`, builds a flat GDT, and enters 32-bit protected mode
- **C++ kernel**: linked as a flat binary at `0x10000`, entered from a small
  assembly stub
- **VGA text driver**: writes directly to `0xB8000`. Clearing, cursor tracking,
  scrolling, 16 colors, and handling for `\n`, `\r`, `\t`, and `\b`
- **Freestanding string functions**: `strlen`, `memset`, `memcpy`, `memmove`,
  since there is no standard library
- Builds at `-O2` with `-Wall -Wextra` clean

## Building

Requires `nasm`, `qemu`, and an `i686-elf` cross toolchain:

```sh
brew install nasm qemu i686-elf-gcc
make run
```

`make term` runs it inside the terminal instead of a window. `make debug` adds
QEMU's exception logging and stops it rebooting on a triple fault. `make clean`
removes all build artifacts.
## Layout

| Path | Purpose                                                 |
|---|---------------------------------------------------------|
| `boot/` | Stage 1 and stage 2 -- real mode through protected mode |
| `kernel/` | Entry stub and C++ sources, drivers, interrupts         |
| `include/` | Headers                                                 |
| `linker.ld` | Memory layout -- kernel placed at `0x10000`             |

## Next

- [x] Hardware cursor via ports `0x3D4` and `0x3D5`
- [x] Zero `.bss` in the entry stub instead of relying on a zeroed disk image
- [x] Set up the IDT
- [ ] Remap the PIC so IRQs stop colliding with CPU exception vectors
- [ ] PS/2 keyboard driver
- [ ] Memory allocator, then `operator new` and `operator delete`
