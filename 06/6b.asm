.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "Enter two capital: $"
    MSG_OUT DB 10,13, "Alphabetically: $"


.CODE 

MAIN PROC
    
    MOV AX,@DATA
    MOV DS, AX
    
    LEA DX, MSG_IN 
    MOV AH,9
    INT 21H
    
    INPUT: 
        MOV AH,1
        INT 21H
        MOV BL,AL
        
        INT 21H
        
        CMP AL,BL
        ;PRINT SMALLER FIRST
        JBE PRINT
        
        ;XCHG AL,BL
        CALL SWAP_PROC
        
        
        
        
    PRINT:
        MOV CL,AL
        
        MOV AH,9
        LEA DX,MSG_OUT
        INT 21H
        
        MOV AH,2
        MOV DL,CL
        INT 21H
        
        MOV DL,BL
        INT 21H    
    
    
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP
        
        
SWAP_PROC PROC
        MOV DL,AL
        MOV AL,BL
        MOV BL,DL
        
        RET
SWAP_PROC ENDP
        
        
END MAIN