.MODEL SMALL
.STACK 100H

.DATA
    
    MSG_IN DB "ENTER ASCII:  $"
    MSG_BIN_OUT DB 10,13, "BINARY: $"
    MSG_ONE_OUT DB 10,13, "ONE:  $"    
        
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG_IN
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    ;AND AL,11111111B
    MOV BL,AL
    
    LEA DX, MSG_BIN_OUT
    MOV AH,9
    INT 21H 

    
    MOV CX,8
    MOV AH,2
    
    COUNT:
        SHL BL,1
        JC ONE
         
        ZERO:
            MOV DL,30H
            INT 21H
            JMP NEXT

        ONE:
            INC BH  
            MOV DL,31H
            INT 21H

        NEXT:
           LOOP COUNT 
            
    
    LEA DX, MSG_ONE_OUT
    MOV AH,9
    INT 21H
    
    MOV AH,2
    ADD BH, 30H
    MOV DL, BH
    INT 21H
     
     
    EXIT: 
        MOV AH,4CH
        INT 21H
    
MAIN ENDP
END MAIN


