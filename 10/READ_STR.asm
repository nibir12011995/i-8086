READ_STR PROC NEAR
    
    ;input: DI of str
    ;output: number of characters BX  
    ;        str stored in DI
    
    PUSH AX
    PUSH DI
    CLD
    XOR BX, BX
    
    MOV AH,1
    INT 21H
    
    REPEAT_READ_STR:
        CMP AL, 0DH
        JE RET_READ_STR
        CMP AL, 8H
        JNE STORE_STRING
        
        BACKSPACE:
            DEC DI
            DEC BX
            JMP READ_STRING
        
        
        STORE_STRING:
            STOSB     ; AL --> ES:DI  >  DI++
            INC BX
                
        READ_STRING:
            INT 21H
            JMP REPEAT_READ_STR    
        
        
    RET_READ_STR:
        POP DI
        POP AX
        RET
        
READ_STR ENDP            