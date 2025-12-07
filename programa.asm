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
    push dword [a]
    push dword [b]
    pop ebx
    pop eax
    cmp eax, ebx
    sete al
    movzx eax, al
    push eax
    push 100
    pop eax
    mov [c], eax
    ret
