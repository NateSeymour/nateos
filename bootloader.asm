bits 16
section .boot
boot:
    .enable_a20:
        mov ax, 0x2401
        int 0x15

    .init_gdt:
        lgdt [gdt_pointer]

    .enable_protected_mode:
        mov eax, cr0
        or eax, 0x1 
        mov cr0, eax

    .set_section_registers:
        mov ax, DATA_SEG
        mov ds, ax
        mov es, ax
        mov fs, ax
        mov gs, ax
        mov ss, ax
    
    .load_initialization_code:
        mov ah, 0x2    ;read sectors
        mov al, 1      ;sectors to read
        mov ch, 0      ;cylinder idx
        mov dh, 0      ;head idx
        mov cl, 2      ;sector idx
        mov bx, copy_target;target pointer
        int 0x13

    .do_initialization:
        cli
        jmp CODE_SEG:init

gdt_start:
	dq 0x0
gdt_code:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
gdt_data:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
gdt_end:
gdt_pointer:
	dw gdt_end - gdt_start
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

times 510 - ($-$$) db 0 ; 512 bytes padding
dw 0xaa55 ; magic boot number

; 32 bit mode
copy_target:

bits 32 
init:
    cli
    hlt

times 1024 - ($-$$) db 0