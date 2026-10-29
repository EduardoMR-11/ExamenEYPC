section .bss
    res_str resb 20              ; Espacio de 20 bytes para guardar el texto del resultado

section .text
    global _start

    ; --- Declaración de símbolos externos de los otros archivos 
    extern leer_caracter         
    extern str_len
    extern string_to_int
    extern Sumar                 
    extern int_to_string
    extern print_string
    extern buffer

_start:
main_suma:
    push ebp
    mov ebp, esp
    sub esp, 16                  ; Reserva espacio para len1, num1, len2 y num2

    ; --- 1. Leer primer número 
    call leer_caracter

    push buffer
    call str_len
    add esp, 4
    mov [ebp-4], eax             ; len1

    push dword [ebp-4]           
    call string_to_int
    add esp, 4
    mov [ebp-8], eax             ; num1

    ; --- 2. Leer segundo número 
    call leer_caracter           

    push buffer
    call str_len
    add esp, 4
    mov [ebp-12], eax            ; len2

    push dword [ebp-12]          
    call string_to_int
    add esp, 4
    mov [ebp-16], eax            ; num2

    ; --- 3. Sumar 
    push dword [ebp-8]           
    push dword [ebp-16]          
    call Sumar                   
    add esp, 8

    ; --- 4. Convertir resultado a texto e imprimir 
    push res_str
    call int_to_string
    add esp, 4

    push res_str
    call print_string
    add esp, 4

    ; --- 5. Salir del programa
    mov esp, ebp
    pop ebp

    mov eax, 1                   ; sys_exit
    xor ebx, ebx
    int 0x80
