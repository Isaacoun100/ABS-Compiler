%include "io.mac"

.DATA

.UDATA

    g resd 1
    h resd 1
    s resb 256
    c resb 1
    tmp resd 1
    t0 resd 1
    local resd 1

.CODE
.STARTUP
main:
    push dword [a]
    push dword [b]
    pop ebx
    pop eax
    add eax, ebx
    mov [t0], eax
    push dword [t0]
    pop eax
    mov [tmp], eax
    push dword [x]
    pop eax
    mov [local], eax
    push 10
    pop eax
    mov [g], eax
    push 20
    pop eax
    mov [h], eax
    mov byte [s + 0], 104
    mov byte [s + 1], 111
    mov byte [s + 2], 108
    mov byte [s + 3], 97
    mov byte [s + 4], 0
    push 'A'
    pop eax
    mov [c], al
done:
    .EXIT
