.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB 10,13, "ENTER DECIMAL STRING:   $"
    MSG_OUT DB 10,13,10,13, "HEX:   $"
    MSG_ERROR DB 10,13, "ILLEGAL INPUT. Enter:   $"
    
    SUM DW ?
    COUNT DW ?
    VALUE_PRINT DW ?

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG_IN
    MOV AH, 9 
    INT 21H
    
    JMP INITIALIZE
    
    ERROR:
        LEA DX, MSG_ERROR
        MOV AH, 9
        INT 21H
    
    
    INITIALIZE:
        XOR AX, AX
        MOV SUM, 0
    
    INPUT:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE SUM_PROCESS
        
        CMP AL, 30H
        JB ERROR
        CMP AL, 39H
        JA ERROR
        
        SUB AL, 30H
        XOR AH, AH
        ADD SUM, AX
        LOOP INPUT
        
        
    SUM_PROCESS:
        MOV BX, SUM
        MOV VALUE_PRINT, BX
        
        LEA DX, MSG_OUT
        MOV AH, 9
        INT 21H
        
        CALL HEX_PRINT_PROC                                         
        
 
    EXIT:
        MOV AH, 4CH
        INT 21H
        
MAIN ENDP


;---------------------------------------------

 HEX_PRINT_PROC PROC
    
    MOV COUNT, 30H
    
    INIT_HEX_PRINT:
        
        XOR DL, DL
        MOV CX, 4
        
    EXTRACT_HEX_PRINT:
        ;declare var in data seg.
        SHL VALUE_PRINT, 1
        RCL DL, 1
        
        LOOP EXTRACT_HEX_PRINT
    

    CMP DL, 9
    JBE INT_HEX_PRINT
    
    SUB DL, 9
    OR DL, 40H
    JMP PRINT_HEX_PRINT
    
            
    INT_HEX_PRINT:
        OR DL, 30H 
    
    PRINT_HEX_PRINT:
        MOV AH,2
        INT 21H
        
        
    INC COUNT
    ;4 times
    CMP COUNT, 34H
    JNE INIT_HEX_PRINT     
    
    RET_HEX_PRINT:
        RET
        
HEX_PRINT_PROC ENDP

END MAIN



