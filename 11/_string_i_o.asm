.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "ENTER:   $"
    
    MSG_OUT DB 10,13,10,13, "OUTPUT:   $"

    STRING DB 80 DUP(0)
    
.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    LEA DX, MSG_IN
    MOV AH,9
    INT 21H
    
    LEA DI, STRING 
    CALL READ_STR
    PUSH BX
    
    ;-----------------------------------
    
    LEA DX, MSG_OUT
    MOV AH,9
    INT 21H
    
    LEA SI, STRING
    POP BX
    CALL REVERSE_PRINT_STR
    
    
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE READ_STR.ASM
INCLUDE REVERSE_PRINT_STR.ASM                
                

END MAIN



