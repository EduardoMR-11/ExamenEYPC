section .data

section .bss

section .text
    global int_to_string
    extern str_rev         

int_to_string:             
    push ebp 
    mov ebp, esp 
    push esi 
    sub esp, 4             ; Reservamos 4 bytes para nuestra variable local

    mov esi, [ebp+8]       ; esi = Dirección del buffer donde se guardará el string
    mov dword [ebp-4], 0   ; [ebp-4] será nuestro contador de caracteres (inicializado en 0)

    cmp eax, 0
    jge _l1
    mov byte [esi], '-'    
    inc dword [ebp-4]      ; <--- CORREGIDO: Incrementamos el contador de tamaño (no [ebp+8]) para dejar espacio al '-'
    neg eax
    jmp _l2

_l1: 
    cmp eax, 0
    jne _l2
    mov ebx, [ebp-4]
    mov byte [esi + ebx], '0'
    inc dword [ebp-4]
    jmp _l3

_l2:
    cmp eax, 0
    jle _l3
    xor edx, edx 
    mov ecx, 10
    div ecx                ; Divide edx:eax entre 10. Cociente en eax, residuo en edx
    add dl, '0'            ; Convierte el residuo a carácter ASCII
    mov ebx, [ebp-4]
    mov byte [esi+ebx], dl 
    inc dword [ebp-4]       
    jmp _l2

_l3:                       
    mov ebx, [ebp-4]
    mov byte [esi+ebx], 0   
    push dword [ebp+8]     ; Pasa el puntero inicial a str_rev
    call str_rev
    add esp, 4

    ; Epílogo de la función
    pop esi
    mov esp, ebp           
    pop ebp
    ret