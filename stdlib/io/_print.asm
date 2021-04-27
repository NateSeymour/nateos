bits 32
section .text
global _print
extern _io_vga_cursor_cords
; Simple routine to print text to the screen. Does not append a newline. Prints chars until it finds a null terminator
; Args: EAX - pointer to string
; Returns: 0
_print:
    push ebp
    push edx
    mov ebp, esp    

    ; Memory location of the vga text buffer
    mov ebx, 0xb8000

    ; Cursor coordinates
    mov ecx, [_io_vga_cursor_cords]
        
    ; clear edx
    xor edx,edx

    .loop:
        test [eax], [eax]
        jz .break

        movb dl, [eax]
        mov [ebx + 
        

    .break:

    ; return 0
    xor eax, eax
    
    pop edx
    pop ebp
    ret

