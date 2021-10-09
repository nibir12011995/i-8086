.MODEL SMALL
.STACK 100H

.DATA
    
    MSG_IN DB "ENTER ASCII:  $"
    MSG_BIN_OUT DB 10,13, "BINARY: $"
    MSG_ONE_OUT DB 10,13, "ONE:  $"
    
    COUNT DB ?
    BIN_HOLD DB ?
        
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG_IN
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    
    ;declare var in data seg.
    MOV BIN_HOLD,AL
    
    
    LEA DX, MSG_BIN_OUT
    MOV AH,9
    INT 21H 
    
    
    CALL BIN_PRNT_ONE_COUNT_PROC 
     
     
    EXIT: 
        MOV AH,4CH
        INT 21H
    
MAIN ENDP


BIN_PRNT_ONE_COUNT_PROC PROC
    
    ;declare var in data seg.
    MOV COUNT, 30H 
    
    ;number of bits 8 16 
    MOV CX,8
    MOV AH,2
    
    ONE_COUNT:
        ;var or reg. where bin stored
        SHL BIN_HOLD, 1
        JC ONE
         
        ZERO:
            MOV DL,30H
            INT 21H
            JMP NEXT

        ONE:
            INC COUNT  
            MOV DL,31H
            INT 21H

        NEXT:
           LOOP ONE_COUNT 
            
    
    ;dec in data
    LEA DX, MSG_ONE_OUT
    MOV AH,9
    INT 21H
    
    MOV AH,2 
    ;use var declared
    MOV DL, COUNT
    INT 21H
    
    RET
    
BIN_PRNT_ONE_COUNT_PROC ENDP


END MAIN


