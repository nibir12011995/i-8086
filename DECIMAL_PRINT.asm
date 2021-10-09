.MODEL SMALL
.STACK 100H

.DATA

    MSG_OUT DB 10,13, "VALUE:  $"


.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    
    CALL INDEC
    PUSH AX  
    
    LEA DX, MSG_OUT
    MOV AH, 9
    INT 21H
    
    ;move value to AX
    POP AX
    CALL OUTDEC
     
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

;---------------------------------------------

INDEC PROC
    
    PUSH BX
    XOR BX,BX
     
    MOV AH,1 
    INT 21H 
    
    JMP END_INDEC 


    INPUT_INDEC:     
    
        MOV AH,1 
        INT 21H  
    
    END_INDEC:    
    
        CMP AL,0DH 
        JE EXIT_INDEC                            
     
    
    AND AX,000FH 
    PUSH AX 
    MOV AX,10 
    MUL BX 
    MOV BX,AX
    POP AX 
    ADD BX,AX 
    
    JMP INPUT_INDEC 


    EXIT_INDEC:

        MOV AX,BX
        POP BX ; retain prev. value 
        RET 
INDEC ENDP

;---------------------------------------------

OUTDEC PROC
    
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
 
 
END MAIN



