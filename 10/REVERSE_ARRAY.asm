REVERSE_ARRAY PROC NEAR
    
    ;word array reverse
    ;input: SI of arr ,
    ;       BX = number of elements
      
    ;output: SI arr reversed
    
    ;4 52 1
    ;1 25 4
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    
    ;DI , SI same arr
    MOV DI, SI
    MOV CX, BX
    ;(N-1)
    DEC BX
    ;(N-1) x 2
    SHL BX, 1
    
    ;DI points last element of arr
    ADD DI, BX
    
    ;CX = n/2
    SHR CX, 1
    
    XCHG_LOOP:
        MOV AX, [SI]
        XCHG AX, [DI]
        MOV [SI], AX
        
        ADD SI, 2
        SUB DI, 2
        
        LOOP XCHG_LOOP
        
    
    RET_REVERSE_ARRAY:
        POP DI
        POP SI
        POP CX
        POP BX
        POP AX
        
        RET                  
    
    
REVERSE_ARRAY ENDP



