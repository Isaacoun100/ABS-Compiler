global main
extern printf

section .data
    fmtInt db "%d", 10, 0

section .bss

    a resd 1
    b resd 1
    c resd 1

section .text
main:
    push 2
    pop eax
    mov [a], eax
    push 5
    pop eax
    mov [b], eax
    push 0
    pop eax
    mov [c], eax
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
    push 100
    pop eax
    mov [c], eax
endif_0:
    ret
