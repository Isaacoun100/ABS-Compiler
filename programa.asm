%include "io.mac"

.DATA

.UDATA

    x resd 1
    y resd 1
    r resd 1
    nombre resb 256
    letra resb 1

.CODE
.STARTUP
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
done:
    .EXIT
