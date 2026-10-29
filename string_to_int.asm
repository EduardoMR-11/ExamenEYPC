section .text
    global string_to_int
    extern buffer

string_to_int:
    push ebp
    mov ebp, esp
    push esi
    push ebx

    mov esi, buffer          ; Dirección del buffer
    xor eax, eax             ; Limpiamos eax (aquí se formará el número)
    movzx ecx, byte [esi]    ; Leemos el primer caracter del buffer

    cmp ecx, 10              ; ¿Es un salto de línea o vacío?
    je .fin
    cmp ecx, 0               ; ¿Es fin de cadena?
    je .fin

    sub ecx, '0'             ; Convertimos de ASCII a entero (ej. '4' -> 4)
    mov eax, ecx             ; Guardamos el valor numérico en eax

.fin:
    pop ebx
    pop esi
    mov esp, ebp
    pop ebp
    ret