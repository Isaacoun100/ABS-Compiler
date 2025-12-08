%include "io.mac"

.DATA

.UDATA

    x resd 1

.CODE
.STARTUP
main:
    push 5
    pop eax
    mov [x], eax
    push 6
    pop eax
    mov [x], eax
    push 0
    pop eax
    cmp eax, 0
    je endif_0
    push 999
    pop eax
    mov [x], eax
endif_0:
done:
    .EXIT
