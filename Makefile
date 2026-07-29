run: disk.img
	qemu-system-x86_64 -drive format=raw,file=disk.img

disk.img: boot.bin stage2.bin kernel.bin
	dd if=/dev/zero of=disk.img bs=512 count=64 2>/dev/null
	dd if=boot.bin   of=disk.img conv=notrunc 2>/dev/null
	dd if=stage2.bin of=disk.img seek=1 conv=notrunc 2>/dev/null
	dd if=kernel.bin of=disk.img seek=9 conv=notrunc 2>/dev/null

boot.bin: boot/boot.asm
	nasm -f bin boot/boot.asm -o boot.bin

stage2.bin: boot/stage2.asm
	nasm -f bin boot/stage2.asm -o stage2.bin

kernel.bin: kernel/entry.asm kernel/kernel.cpp linker.ld
	nasm -f elf32 kernel/entry.asm -o entry.o
	i686-elf-g++ -ffreestanding -fno-exceptions -fno-rtti -c kernel/kernel.cpp -o kernel.o
	i686-elf-ld -T linker.ld --oformat binary -o kernel.bin entry.o kernel.o