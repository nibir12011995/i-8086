.MODEL SMALL
.STACK 100H

.DATA
    
    MSG_IN DB 10,13, "ENTER: $"
    MSG_REPEAT DB 10,13, 'Y or y : $'


.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS,AX
    
    INPUT:
        LEA DX, MSG_IN
        MOV AH,9
        INT 21H
        
        MOV AH,1
        INT 21H
        MOV BL,AL
        
        CMP AL,"0"
        JB INPUT
        
        CMP AL,"F"
        JA INPUT
    
    
    MOV AH,2
    MOV DL,0AH
    INT 21H
    ;MOV DL,0DH
    ;INT 21H

    CMP BL,39H
    JBE PRINT
    CMP BL,41H
    JAE PRINT_CHAR
    
    
    
    PRINT:
        MOV AH,2
        MOV DL,BL
        INT 21H
        JMP REPEAT
        
    PRINT_CHAR:
        MOV AH,2
        MOV DL,31H
        INT 21H
        SUB BL,11H
        MOV DL,BL
        INT 21H
        
        
        
    
    REPEAT:
        MOV AH,9
        LEA DX, MSG_REPEAT
        INT 21H
        
        MOV AH,1
        INT 21H
        
        CMP AL,"y"
        JE INPUT
        CMP AL,"Y"
        JE INPUT
        
        
            
           
    
    EXIT:
        MOV AH,4CH
        INT 21H
    
    MAIN ENDP
END MAIN



