CXX      := i686-elf-g++
LD       := i686-elf-ld
CXXFLAGS := -ffreestanding -fno-exceptions -fno-rtti -Wall -Wextra -Iinclude

SRCS := $(shell find kernel -name '*.cpp')
OBJS := $(SRCS:.cpp=.o)

.PHONY: run term debug clean

run: disk.img
	./run.sh

term: disk.img
	./run.sh curses

debug: disk.img
	./run.sh debug

disk.img: boot.bin stage2.bin kernel.bin
	dd if=/dev/zero  of=disk.img bs=512 count=64 2>/dev/null
	dd if=boot.bin   of=disk.img conv=notrunc 2>/dev/null
	dd if=stage2.bin of=disk.img seek=1 conv=notrunc 2>/dev/null
	dd if=kernel.bin of=disk.img seek=9 conv=notrunc 2>/dev/null

boot.bin: boot/boot.asm
	nasm -f bin $< -o $@

stage2.bin: boot/stage2.asm
	nasm -f bin $< -o $@

kernel/entry.o: kernel/entry.asm
	nasm -f elf32 $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

kernel.bin: kernel/entry.o $(OBJS) linker.ld
	$(LD) -T linker.ld --oformat binary -o $@ kernel/entry.o $(OBJS)

clean:
	rm -f boot.bin stage2.bin kernel.bin disk.img $(OBJS) kernel/entry.o