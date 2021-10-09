NEG_INDEC PROC NEAR
    ;reads number range[-32768, 32767]
    ;input: none
    
    ;output: AX -> binary equivalent of number 
    
    PUSH BX
    PUSH CX 
    PUSH DX
    
    BEGIN:
        XOR BX, BX   ; total = 0
        XOR CX, CX   ; flag neg = 0 =false
        
        MOV AH,1
        INT 21H
        
        CMP AL, '-'
        JE MINUS
        CMP AL, '+'
        JE PLUS
        
        JMP REPEAT2
        
        MINUS:
            MOV CX, 1  ; neg = true
        PLUS:
            INT 21H
            
        REPEAT2:
            CMP AL, '0'
            JNGE NOT_DIGIT
            CMP AL, '9'
            JNLE NOT_DIGIT
            
            AND AX, 000FH
            PUSH AX
            
            MOV AX, 10
            MUL BX
            POP BX
            ADD BX, AX
            
            MOV AH,1
            INT 21H
            
            CMP AL, 0DH
            JNE REPEAT2
            
            MOV AX, BX
            OR CX, CX    ; if negative
            JE RET_NEG_INDEC
            
            NEG AX       ; 2's complement
            
    RET_NEG_INDEC:
        POP DX
        POP CX
        POP BX 
        RET
        
    NOT_DIGIT:
        MOV AH,2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        JMP BEGIN
        
        
NEG_INDEC ENDP            
                    
        
        