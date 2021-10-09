.MODEL SMALL
.STACK 100H

.DATA
    
    ;A DW 4,5,2,10    ;change BX=4 CX=4
    A DW 5,2,1,3,4
    
.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA SI, A
    ;=======
    MOV BX, 5
    CALL REVERSE_ARRAY
    ;=======
    MOV CX, 5
    LEA SI, A
    
    REPEAT:
        MOV AX, [SI]
        CALL OUTDEC
        
        MOV DL, 20H
        MOV AH,2
        INT 21H
        
        ADD SI, 2 
        LOOP REPEAT    
    
                 
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE REVERSE_ARRAY.ASM
INCLUDE OUTDEC.ASM                 
                

END MAIN



