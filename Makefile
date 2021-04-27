CC=gcc
C_COMPILE_ARGS=-m32 -nostdlib -ffreestanding -mno-red-zone -fno-exceptions -Wall -Wextra -Werror

all: bootloader kernel link

output_dir: 
	mkdir -p build build/bin build/include

bootloader: output_dir
	nasm -f elf32 boot/bootloader.asm -o build/boot.o

kernel: bootloader
	$(CC) $(C_COMPILE_ARGS) -c kernel/kernel.c -o build/kernel.o 	

link: bootloader kernel	
	$(CC) -m32 build/boot.o build/kernel.o -o build/bin/kernel.bin -nostdlib -ffreestanding -mno-red-zone -T linker.ld
