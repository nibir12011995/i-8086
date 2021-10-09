.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "ENTER:   $"
    
    MSG_Z DB 10,13,10,13, "Z:   $"
    MSG_S DB 10,13, "S:   $"

    STRING DB 80 DUP(0)
    Z DB "z"
    S DB "s"
    
    ZCOUNT DW 0
    SCOUNT DW 0
    
.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    LEA DX, MSG_IN
    MOV AH,9
    INT 21H
    
    LEA DI, STRING 
    CALL READ_STR
    PUSH BX
    
    ;-------------------------------------
    
    CLD
    POP BX
    LEA SI, STRING
    REPEAT:
        LODSB
        LEA DI, Z
        MOV CX,1
        REPNE SCASB
        JNZ S_COUNT  ;ZF=0
        
        Z_COUNT:
            INC ZCOUNT
            JMP END_REPEAT
        
        S_COUNT:
            LODSB 
            LEA DI, S
            SCASB
            JNZ END_REPEAT ;ZF=0
            
            INC SCOUNT

       END_REPEAT:
            DEC BX
            JNZ REPEAT
    
    
    LEA DX, MSG_Z
    MOV AH,9
    INT 21H
    MOV AX, ZCOUNT 
    CALL OUTDEC
    
    LEA DX, MSG_S
    MOV AH,9
    INT 21H
    MOV AX, SCOUNT
    CALL OUTDEC
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE READ_STR.ASM
INCLUDE PRINT_STR.ASM
INCLUDE OUTDEC.ASM                
                

END MAIN



