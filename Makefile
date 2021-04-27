all: bootloader kernel

output_dir: 
	mkdir -p build build/bin

bootloader: output_dir
	nasm -f elf32 bootloader.asm -o build/bin/boot.o

kernel: bootloader
	i386-elf-_gcc x86_64-elf-gcc -m64 build/bin/boot.o -o kernel.bin -nostdlib -ffreestanding -mno-red-zone -fno-exceptions -nostdlib -fno-rtti -Wall -Wextra -Werror -T linker.ld
