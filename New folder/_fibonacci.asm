.MODEL SMALL
.STACK 100H

.DATA
      
      MSG_IN DB "ENTER:   $"
      N DW ?
      SUM DW 0
      VAL DW 1
      
      FIB  DW 0, 1, 2, 3, 5, 7 ,11,13,17,19,23,29 
      
      COUNT DW 10
      CLRF DB 10,13, "$"

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    
    LEA DX, MSG_IN
    MOV AH,9
    INT 21H
    
    CALL INDEC
    MOV N, AX
    
    LEA DX, CLRF
    MOV AH,9
    INT 21H
    
    LEA SI, FIB
    MOV AX, [SI] 
    MOV BX, VAL
    
    REPEAT: 
        ADD SI, 2
        MOV AX, [SI]
        ;MOV AX, VAL
        ADD SUM, AX
        
        ;MOV AX, SUM
        CALL OUTDEC
        MOV DL, 20H
        MOV AH,2
        INT 21H
        
        DEC N
        JNL REPEAT
        
           
        
    
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE INDEC.ASM
INCLUDE OUTDEC.ASM

END MAIN



