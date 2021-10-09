.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "ENTER:   $"
    MSG_OUT DB 10,13,10,13, "REVERSE:   $"
    
    
    COUNT DW 0

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG_IN
    MOV AH, 9
    INT 21H
    
    XOR CX, CX
    MOV AH, 1    
    
    INPUT:
        INT 21H
        
        CMP AL, 0DH
        JE STACK_PROCESS
        
        INC CX
        PUSH AX
        JMP INPUT
    
        
    STACK_PROCESS:
        MOV BX, 50H

        XCHG BX, SP
        
        PUSH 0020H
        
        XCHG BX, SP
        
        INC COUNT
        
        ;CX already hold the number of inputs
        EXTRACT:
            POP DX
            XCHG BX, SP
            PUSH DX
            XCHG BX, SP
            INC COUNT
            LOOP EXTRACT
    
    
    
    LEA DX, MSG_OUT
    MOV AH, 9
    INT 21H
    
    MOV CX, COUNT
    MOV COUNT, 0
    
    PUSH 0020H
    INC COUNT        
    
    PRINT_REVERSE:
    
        XCHG BX, SP
        POP DX
        XCHG BX, SP
        
        CMP DL, 20H
        JNE KEEP_EXTRACT
        
        
        MOV AH, 2
        GO_PRINT:
            POP DX
            INT 21H
            
            DEC COUNT
            JNZ GO_PRINT
            
            
        MOV DX, 0020H
        KEEP_EXTRACT:
            PUSH DX
            INC COUNT
             
            LOOP PRINT_REVERSE
        
        

            
    EXIT:
        MOV AH, 4CH
        INT 21H            
    
MAIN ENDP
END MAIN



