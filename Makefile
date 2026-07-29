run: disk.img
	qemu-system-x86_64 -drive format=raw,file=disk.img

disk.img: boot.bin stage2.bin
	cat boot.bin stage2.bin > disk.img

boot.bin: boot/boot.asm
	nasm -f bin boot/boot.asm -o boot.bin

stage2.bin: boot/stage2.asm
	nasm -f bin boot/stage2.asm -o stage2.bin