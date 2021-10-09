OUTDEC PROC NEAR   
    
    ;input: int in AX
    
    PUSH BX
    PUSH CX
    PUSH DX 
    
    XOR CX, CX                
    MOV BX, 10                    

    CALC_OUTDEC:                       
        XOR DX, DX                  
        DIV BX                      
        PUSH DX
                      
        INC CX
                       
        CMP AX,0                   
        JNZ CALC_OUTDEC                  


    MOV AH, 2                     
    PRINT_OUTDEC:                     
        POP DX                     
        OR DL, 30H                  
        INT 21H                     
        LOOP PRINT_OUTDEC                  
              
    RETURN_OUTDEC:
        POP BX
        POP CX
        POP DX
        RET 
                             
OUTDEC ENDP
 