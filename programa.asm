%include "io.mac"

.DATA

.UDATA

    s1 resb 256
    s2 resb 256
    x resd 1
    y resd 1
    z resd 1
    t0 resd 1
    t1 resd 1
    t2 resd 1
    t3 resd 1

.CODE
.STARTUP
main:
    mov byte [s1 + 0], 104
    mov byte [s1 + 1], 111
    mov byte [s1 + 2], 108
    mov byte [s1 + 3], 97
    mov byte [s1 + 4], 0
    mov esi, s1
    mov edi, s2
copyStr_loop_1:
    mov al, [esi]
    mov [edi], al
    cmp al, 0
    je copyStr_end_2
    inc esi
    inc edi
    jmp copyStr_loop_1
copyStr_end_2:
    push 5
    pop eax
    mov [x], eax
    push 3
    pop eax
    mov [y], eax
    push dword [x]
    push dword [y]
    pop ebx
    pop eax
    add eax, ebx
    mov [t0], eax
    push dword [t0]
    pop eax
    mov [z], eax
    push dword [z]
    push 2
    pop ebx
    pop eax
    sub eax, ebx
    mov [t1], eax
    push dword [t1]
    pop eax
    mov [z], eax
    push dword [x]
    pop eax
    inc eax
    mov [x], eax
    mov [t2], eax
    push dword [t2]
    pop eax
    mov [x], eax
    push dword [y]
    pop eax
    dec eax
    mov [y], eax
    mov [t3], eax
    push dword [t3]
    pop eax
    mov [y], eax
    push dword [z]
    push dword [x]
    pop ebx
    pop eax
    cmp eax, ebx
    sete al
    movzx eax, al
    push eax
    pop eax
    cmp eax, 0
    je startElse_1
    mov byte [s1 + 0], 105
    mov byte [s1 + 1], 103
    mov byte [s1 + 2], 117
    mov byte [s1 + 3], 97
    mov byte [s1 + 4], 108
    mov byte [s1 + 5], 101
    mov byte [s1 + 6], 115
    mov byte [s1 + 7], 0
    jmp endif_0
startElse_1:
    mov byte [s1 + 0], 100
    mov byte [s1 + 1], 105
    mov byte [s1 + 2], 115
    mov byte [s1 + 3], 116
    mov byte [s1 + 4], 105
    mov byte [s1 + 5], 110
    mov byte [s1 + 6], 116
    mov byte [s1 + 7], 111
    mov byte [s1 + 8], 115
    mov byte [s1 + 9], 0
endif_0:
done:
    .EXIT
