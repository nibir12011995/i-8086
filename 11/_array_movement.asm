.MODEL SMALL
.STACK 100H

.DATA
    
    MSG_Z DB 10,13,10,13, "Z:   $"
    MSG_S DB 10,13, "S:   $"

    
    W DB 4,5,2,10
    
.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    
    ;MOV BYTE PTR [W], 10
;    ;MOV AL, [W]
;    ;AND AX, 000FH
;    ;CALL OUTDEC
;    
;    ADD W, 3
;    MOV BYTE PTR [W], 4
;    ;SUB W, 3
;    
;    ;ADD W, 1
;    MOV BYTE PTR [W], 2
;    ;SUB W, 1
;    
;    ;ADD W, 2
;    MOV BYTE PTR [W],5
;    ;SUB W, 2  
;    
    
    MOV CX,4
    
    MOV BX,0
    
    REPEAT:
        
        ADD W, BL
        MOV AL, [W]
        AND AX, 000FH
        PUSH BX
        CALL OUTDEC
        
        POP BX
        INC BX
        
        LOOP REPEAT 
    
    
    
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE READ_STR.ASM
INCLUDE PRINT_STR.ASM
INCLUDE OUTDEC.ASM                
                

END MAIN



