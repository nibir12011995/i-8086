.MODEL SMALL
.STACK 100H

.DATA 

    MSG_IN_FIRST DB 10,13, "ENTER FIRST HEX:   $"
    MSG_IN_SECOND DB 10,13, "ENTER SECOND HEX:  $"
    MSG_IN_ERROR DB 10,13, "ILLEGAL INPUT. Enter Again:   $"
    
    MSG_SUM_OUT DB 10,13,10,13, "SUM :   $"
    
    COUNT DB ?
    RET_VALUE DW ?
    
    FIRST_HEX DW ?
    SECOND_HEX DW ?
    
    SUM DW ?

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG_IN_FIRST
    MOV AH,9
    INT 21H
    
    CALL HEX_INPUT_PROC
    MOV AX, RET_VALUE
    MOV FIRST_HEX, AX

    
    LEA DX, MSG_IN_SECOND
    MOV AH,9
    INT 21H
    
    CALL HEX_INPUT_PROC
    MOV AX, RET_VALUE
    MOV SECOND_HEX, AX
    
    
    ;PRINT SUM
    LEA DX, MSG_SUM_OUT
    MOV AH, 9
    INT 21H
    
    MOV AX, FIRST_HEX
    MOV BX, SECOND_HEX
    
    ADD BX, AX
    MOV SUM, BX
    JNC GO_PRINT
    
    ;print carry 1
    MOV DL, 31H
    MOV AH,2
    INT 21H 
    
    GO_PRINT:

        CALL HEX_PRINT_PROC
        
    
    EXIT: 
        MOV AH, 4CH
        INT 21H
          
MAIN ENDP


HEX_PRINT_PROC PROC
    
    MOV COUNT, 30H
    
    INIT_HEX_PRINT:
        
        XOR DL, DL
        MOV CX, 4
        
    EXTRACT_HEX_PRINT:
        SHL SUM, 1
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

;------------------------------------------------ 
 
HEX_INPUT_PROC PROC
    
    JMP INITIALIZE
    
    ERROR:
        ;dec in data seg.
        LEA DX, MSG_IN_ERROR
        MOV AH,9
        INT 21H
        
    INITIALIZE:
    
        XOR BX,BX
        ;dec var in data seg.
        MOV COUNT, 30H     
        
    INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL, 0DH
        JE RET_HEX_INPUT
        
        CMP AL, 30H
        JB ERROR
        CMP AL, "F"
        JA ERROR
        
        CMP AL, 41H
        JB PROCESSING
        
        CHAR_PROCESSING:
            SUB AL, 37H
            
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
        
        ;how many to input(4)        
        CMP COUNT, 34H
        JE RET_HEX_INPUT
        JMP INPUT
        
    RET_HEX_INPUT:
        
        MOV RET_VALUE, BX
        RET             
    
HEX_INPUT_PROC ENDP

;-----------------------------------------------

END MAIN



