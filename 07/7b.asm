.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "ENTER HEX:  $"
    MSG_BIN_OUT DB 10,13,10,13, "BIN:   $"
    MSG_ERROR DB 10,13, "Illegal Input. Enter :  $"

    COUNT DB ?
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG_IN
    MOV AH,9
    INT 21H
    
    JMP INITIALIZE
    
    ERROR:
        LEA DX, MSG_ERROR
        MOV AH,9
        INT 21H
        
    
    INITIALIZE:
        
        AND BX,0H
        MOV COUNT, 30H

    INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JE BIN_OUT
        
        CMP AL, 30H
        JB ERROR
        CMP AL, "F"
        JA ERROR
        
        CMP AL, 41H
        JB PROCESSING
        
        CHAR_PROCESSING:
            SUB AL,37H    
            
        PROCESSING:
        
            INC COUNT
            
            AND AL, 0FH
            
            MOV CL, 4
            SHL AL, CL
            
            MOV CX, 4
            
            EXTRACT:
                SHL AL, 1
                RCL BX, 1
                
                LOOP EXTRACT 
                    
        
       CMP COUNT, 34H
       JE BIN_OUT
       JMP INPUT
   
        
    BIN_OUT:
    
        LEA DX, MSG_BIN_OUT
        MOV AH,9
        INT 21H
        
        MOV CX, 16
        
        
        CALL BIN_CALC_PROC
                
         
    
        
    
    EXIT: 
        MOV AH,4CH
        INT 21H    
    
MAIN ENDP


BIN_CALC_PROC PROC
    
    MOV COUNT, 30H
    
    MOV CX,16
    MOV AH,2
    
    REPEAT_COUNT:
        SHL BX,1
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
           LOOP REPEAT_COUNT 
            
    
    ;LEA DX, MSG_ONE_OUT
;    MOV AH,9
;    INT 21H
;    
;    MOV AH,2
;    MOV DL, COUNT
;    INT 21H    
    
BIN_CALC_PROC ENDP

END MAIN