%include "io.mac"

.DATA

.UDATA

    a resd 1
    b resd 1
    msg resb 256

.CODE
.STARTUP
main:
    push 5
    pop eax
    mov [b], eax
    push 3
    pop eax
    mov [a], eax
    push dword [a]
    push dword [b]
    pop ebx
    pop eax
    cmp eax, ebx
    sete al
    movzx eax, al
    push eax
    pop eax
    cmp eax, 0
    je endif_0
    push 1
    pop eax
    mov [a], eax
endif_0:
done:
    .EXIT
