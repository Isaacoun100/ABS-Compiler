%include "io.mac"

.DATA

.UDATA

    s1 resb 256
    s2 resb 256
    x resd 1
    y resd 1
    z resd 1
    c resb 1
    t0 resd 1
    t1 resd 1
    t2 resb 256

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
    push 10
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
    push 'A'
    pop eax
    mov [c], al
    PutLInt [x]
    nwln
    mov eax, 42
    PutLInt eax
    nwln
    push dword [z]
    push 1
    pop ebx
    pop eax
    add eax, ebx
    mov [t1], eax
    PutLInt [t1]
    nwln
    PutCh [c]
    nwln
    mov al, 'Z'
    PutCh al
    nwln
    PutStr s1
    nwln
    mov byte [t2 + 0], 32
    mov byte [t2 + 1], 109
    mov byte [t2 + 2], 117
    mov byte [t2 + 3], 110
    mov byte [t2 + 4], 100
    mov byte [t2 + 5], 111
    mov byte [t2 + 6], 0
    PutStr t2
    nwln
    PutStr s2
    nwln
done:
    .EXIT
