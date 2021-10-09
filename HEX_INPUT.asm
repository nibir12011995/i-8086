.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "ENTER HEX:  $"
    MSG_IN_ERROR DB 10,13, "Illegal Input. Enter :  $"

    COUNT DB ?
    RET_VALUE DW ?
    
    HEX_VALUE DW ?
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG_IN
    MOV AH,9
    INT 21H
    
    
    ;RET_VALUE declare in data seg. ( DW )
    CALL HEX_INPUT_PROC
    MOV AX, RET_VALUE
    MOV HEX_VALUE, AX
    
     
     
    EXIT: 
        MOV AH,4CH
        INT 21H    
    
MAIN ENDP



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
        
        ;dec var ( DW )
        MOV RET_VALUE, BX
        RET             
    
HEX_INPUT_PROC ENDP

END MAIN