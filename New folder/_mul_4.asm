.MODEL SMALL
.STACK 100H

.DATA
      
      MSG_IN DB "ENTER:   $"
      ID DW ?
      SUM DW 0
      
      DIVISOR DW 4   
      
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
    MOV ID, AX
    
    LEA DX, CLRF
    MOV AH,9
    INT 21H
    
    MOV BX, ID
    REPEAT:
        MOV AX, ID
        XOR DX, DX
        DIV DIVISOR 
        
        CMP DX, 0
        JE PRINT_DEC
        
        INC ID
        DEC COUNT
        JNZ REPEAT
   
   JMP EXIT
         
   PRINT_DEC:
        MOV AX, ID
        CALL OUTDEC
        
        MOV DL, 20H
        MOV AH,2
        INT 21H
        
        INC ID
        DEC COUNT
        JNZ REPEAT      
        
        
    
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE INDEC.ASM
INCLUDE OUTDEC.ASM

END MAIN



