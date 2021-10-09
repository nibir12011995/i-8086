PRINT_STR PROC NEAR
    
    ;input: SI of string , 
    ;       BX = num of chars in string
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    PUSH SI
    
    ADD SI, BX
    MOV CX, BX
    JCXZ RET_PRINT_STR
    
    STD
    MOV AH,2
    START:
        LODSB       ; DS:SI  -->  AL  > SI--
        MOV DL, AL
        INT 21H
        LOOP START
    
    RET_PRINT_STR:
        POP SI
        POP DX 
        POP CX
        POP BX
        POP AX
        
        RET
        
PRINT_STR ENDP            