.MODEL SMALL
.STACK 100H

.DATA
    
    MSG_IN_SUB DB  "SUBSTRING:   $"
    MSG_IN_MAIN DB 10,13, "MAIN STRING:   $"
    
    MAINSTR DB 80 DUP(0)
    SUBSTR DB 80 DUP(0)
    
    STOP DW ?
    START DW ?
    SUB_LEN DW ?
    
    MSG_YES DB 10,13, 'SUBSTRING $'
    MSG_NO DB 10,13, 'NOT SUBSTRING $'
    
    
.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    LEA DX, MSG_IN_SUB
    MOV AH,9
    INT 21H
    
    LEA DI, SUBSTR
    CALL READ_STR
    MOV SUB_LEN, BX
    
    
    LEA DX, MSG_IN_MAIN
    MOV AH,9
    INT 21H
    
    LEA DI, MAINSTR
    CALL READ_STR
    
    ;common cases
    OR BX, BX    ; check if main str len is 0
    JE NO
    CMP SUB_LEN, 0
    JE NO
    CMP SUB_LEN, BX
    JG NO
    
    
    ;----------------------------------
    
    LEA SI, SUBSTR
    LEA DI, MAINSTR
    
    CLD
    
    ;STOP calc
    MOV STOP, DI
    ADD STOP, BX
    MOV CX, SUB_LEN
    SUB STOP, CX
    
    ;initialize start
    MOV START, DI
    
    REPEAT:
        MOV CX, SUB_LEN
        MOV DI, START
        LEA SI, SUBSTR
        REPE CMPSB          ;  SI - DI
        JE YES
        
        INC START
        ; check if START <= STOP
        MOV AX, START
        CMP AX, STOP
        JNLE NO
        
        JMP REPEAT
        
    YES:
        LEA DX, MSG_YES
        MOV AH,9
        INT 21H
        
        JMP EXIT
        
    NO:
        LEA DX, MSG_NO
        MOV AH, 9
        INT 21H        
        
                 
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE READ_STR.ASM
INCLUDE PRINT_STR.ASM                 
                

END MAIN



