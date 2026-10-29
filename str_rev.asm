section .data

section .bss

section .text

global str_rev
extern str_len

str_rev:
    push ebp
    mov ebp, esp
    push esi
    sub esp, 16

    ; Obtener la longitud de la cadena
    push dword [ebp+8]
    call str_len
    add esp, 4

    ; Guardar la longitud temporalmente
    mov dword [ebp-8], eax

    ; left = 0
    mov dword [ebp-12], 0

    ; right = len - 1
    mov eax, [ebp-8]
    dec eax
    mov dword [ebp-16], eax

.start:
    ; Comparar left y right
    mov eax, [ebp-12]
    cmp eax, [ebp-16]
    jge .end

    ; esi = cadena + left
    mov esi, [ebp+8]
    add esi, [ebp-12]

    ; Guardar el carácter izquierdo
    mov al, [esi]
    mov byte [ebp-8], al

    ; ecx = cadena + right
    mov ecx, [ebp+8]
    add ecx, [ebp-16]

    ; Intercambiar los caracteres
    mov dl, [ecx]
    mov [esi], dl

    mov al, [ebp-8]
    mov [ecx], al

    ; left++
    inc dword [ebp-12]

    ; right--
    dec dword [ebp-16]

    jmp .start

.end:
    add esp, 16
    pop esi
    mov esp, ebp
    pop ebp
    ret
