INDEC PROC NEAR 
    
    ;input: 
    ;output: value in AX
    
    PUSH BX
    XOR BX,BX
     
    MOV AH,1 
    INT 21H 
    
    JMP END_INDEC 


    INPUT_INDEC:     
    
        MOV AH,1 
        INT 21H  
    
    END_INDEC:    
    
        CMP AL,0DH 
        JE EXIT_INDEC                            
     
    
    AND AX,000FH 
    PUSH AX 
    MOV AX,10 
    MUL BX 
    MOV BX,AX
    POP AX 
    ADD BX,AX 
    
    JMP INPUT_INDEC 


    EXIT_INDEC:

        MOV AX,BX
        POP BX ; retain prev. value 
        RET 
INDEC ENDP