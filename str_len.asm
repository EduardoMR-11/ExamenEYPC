section .data

section .bss

section .text

global str_len

str_len:
    push ebp
    mov ebp, esp
    push esi
    sub esp, 4
    mov dword [ebp-8], 0
    mov esi, [ebp+8]
    mov ebx, 0
_start:
    add esi, ebx
    cmp byte [esi], 0
    je _end
    inc dword [ebp-8]
    mov ebx, 1
    jmp _start
_end:
    mov eax, [ebp-8]
    add esp, 4
    pop esi
    mov esp, ebp
    pop ebp
    ret
