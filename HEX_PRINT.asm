.MODEL SMALL
.STACK 100H

.DATA

    MSG_OUT DB "HEX:   $"
    
    COUNT DB ?
    
    VALUE_PRINT DW ?

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG_OUT
    MOV AH, 9
    INT 21H
    
    ;move the value to print in VALUE_PRINT (DW)
    MOV VALUE_PRINT, 0AF3H
    
    
    CALL HEX_PRINT_PROC
     
    
    EXIT:
        MOV AH, 4CH
        INT 21H       
    
MAIN ENDP


;---------------------------------------------

 HEX_PRINT_PROC PROC
    ;declare var in data seg. ( DW )
    MOV COUNT, 30H
    
    INIT_HEX_PRINT:
        
        XOR DL, DL
        MOV CX, 4
        
    EXTRACT_HEX_PRINT:
        ;declare var in data seg. ( DW )
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
 
;------------------------------------------------

END MAIN



