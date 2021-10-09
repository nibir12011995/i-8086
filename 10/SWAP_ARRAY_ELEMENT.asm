SWAP PROC
    ;swaps two array elements
    ;input: SI = one element  (LAST ELEMENT HERE)
    ;       DI = other element
    
    ;output: SI = other , DI = one
    
    PUSH AX
    MOV AL, [SI]
    XCHG AL, [DI]
    MOV [SI], AL
    POP AX
    RET
SWAP ENDP