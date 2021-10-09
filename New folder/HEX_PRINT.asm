
    
    ;move the value to print in SI (DW)

;---------------------------------------------
HEX_PRINT_PROC PROC
    ;declare var in data seg. ( DW )
    MOV BX, 30H
    
    INIT_HEX_PRINT:
        
        XOR DL, DL
        MOV CX, 4
        
    EXTRACT_HEX_PRINT:
        ;declare var in data seg. ( DW )
        SHL SI, 1
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
        
        
    INC BX
    ;4 times
    CMP BX, 34H
    JNE INIT_HEX_PRINT     
    
    RET_HEX_PRINT:
        RET
        
HEX_PRINT_PROC ENDP



