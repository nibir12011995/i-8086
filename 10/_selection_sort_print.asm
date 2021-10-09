.MODEL SMALL
.STACK 100H
.DATA


      A DW 5,2,1,3,4
    


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA SI, A
    MOV BX, 5
    CALL SELECTION_SORT
    
    MOV CX, 5
    LEA SI, A
    REPEAT:
        MOV AX, [SI]
        CALL OUTDEC
        
        ;SPACE
        MOV DL, 20H
        MOV AH,2
        INT 21H
        
        ;inc SI
        ADD SI, 2
        LOOP REPEAT
        
    
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP

INCLUDE SELECTION_SORT.ASM
INCLUDE OUTDEC.ASM

END MAIN