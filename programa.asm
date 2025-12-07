global main
extern printf

section .data
    fmtInt db "%d", 10, 0

section .bss

    a resd 1
    b resd 1
    c resd 1
    x resb 1
    y resd 1

section .text
main:
    push 4
    push 5
    pop ebx
    pop eax
    add eax, ebx
    push eax
    pop eax
    mov [a], eax
    ret
