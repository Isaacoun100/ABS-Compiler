global main
extern printf

section .data
    fmtInt db "%d", 10, 0

section .bss

    a resd 1
    b resd 1

section .text
main:
    ret
