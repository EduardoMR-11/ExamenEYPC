section .text
    global Sumar

Sumar:
    push ebp
    mov ebp, esp                 
    mov eax, [ebp+12]            ; Primer número (num1)
    mov ebx, [ebp+8]             ; Segundo número (num2)
    add eax, ebx                 ; Resultado queda en eax
    mov esp, ebp                
    pop ebp
    ret