%include "io.mac"

.DATA

.UDATA

    x resd 1
    y resd 1
    s resb 256
    g resd 1

.CODE
.STARTUP
main:
    push 10
    pop eax
    mov [x], eax
done:
    .EXIT
