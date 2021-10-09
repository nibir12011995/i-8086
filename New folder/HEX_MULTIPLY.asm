.MODEL SMALL
.STACK 100H


.DATA

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        CALL HEX_MULTIPLY
        PUSH DX
        
        POP SI 
        CALL HEX_PRINT_PROC
        
        
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE HEX_PRINT.ASM

HEX_MULTIPLY PROC
    
    ;multiply two number a b by shifting and adding
    ;output: product -> DX
    
    MOV AX, 0004H
    MOV BX, 0007H
    PUSH AX
    PUSH BX
    XOR DX, DX
    
    REPEAT_HEX_MUL:
        TEST BX, 1    ;   if B is ODD
        JZ END_IF_HEX
        
        ADD DX, AX
        
        END_IF_HEX:
            SHL AX, 1
            SHR BX, 1
            
            JNZ REPEAT_HEX_MUL
            
            POP BX 
            POP AX
            RET
            
HEX_MULTIPLY ENDP            
    

END MAIN



