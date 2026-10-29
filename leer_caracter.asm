section .data
    msg db "Ingresa un numero: ", 10
    len equ $ - msg
    salto db 10

section .bss
    global buffer
    global res_str           
    buffer resb 20
    res_str resb 20

section .text
    global leer_caracter
    global print_string
    extern str_len           

leer_caracter:
    ; --- Imprime mensaje de instrucción (sys_write) ---
    mov eax, 4           ; Corrección: 4 es sys_write 
    mov ebx, 1           ; Descriptor 1 = stdout
    mov ecx, msg         ; Dirección del mensaje en ecx
    mov edx, len         ; Longitud del mensaje
    int 0x80

    ; --- Lee desde el teclado (sys_read) ---
    mov eax, 3           ; 3 = sys_read
    mov ebx, 0           ; Descriptor 0 = stdin (teclado)
    mov ecx, buffer      ; Guardar entrada en buffer
    mov edx, 20          ; Leer máximo 20 bytes
    int 0x80
    ret

print_string:
    push ebp
    mov ebp, esp

    ; Calculamos la longitud de la cadena a imprimir usando str_len
    push dword [ebp+8]
    call str_len
    add esp, 4           ; eax ahora tiene la longitud de la cadena

    ; --- Imprime el resultado (sys_write) ---
    mov edx, eax         ; Longitud devuelta por str_len
    mov eax, 4           ; sys_write
    mov ebx, 1           ; stdout
    mov ecx, [ebp+8]     ; Dirección de la cadena a imprimir
    int 0x80

    ; --- Imprime un salto de línea ---
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    mov esp, ebp
    pop ebp
    ret