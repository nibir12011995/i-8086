.MODEL SMALL
.STACK 100H

.DATA


.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AX, 1
    MOV BX, 2
    PUSH AX
    PUSH BX
    POP BX
    
    ;ADD SP, 2
    POP AX
    PUSH BX
    PUSH AX
    
    
    POP AX
    CALL OUTDEC
    POP AX
    CALL OUTDEC
    
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE OUTDEC.ASM

END MAIN



