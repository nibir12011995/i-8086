.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "ENTER:   $"
    MSG_NOCAP DB 10,13, "NO CAPITALS.$"
    MSG_FIRST DB 10,13, "FIRST:   "   
    FIRST DB ']'
              DB ' LAST:  '
    LAST DB '@$'
    ;MSG_LAST DB 10,13, "LAST:   $"

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,9
    LEA DX, MSG_IN
    INT 21H
    
    MOV AH,1
    INT 21H
    
    WHILE_:
        CMP AL, 0DH
        JE END_WHILE
        
        CMP AL, 'A'
        JNGE END_IF
        CMP AL, 'Z'
        JNLE END_IF
        
        CMP AL, FIRST
        JNL CHECK_LAST
        MOV FIRST, AL
        
        CHECK_LAST:
            CMP AL, LAST
            JNG END_IF
            
            MOV LAST, AL
            
        END_IF:
            INT 21H
            JMP WHILE_
            
    END_WHILE:
        MOV AH,9
        CMP FIRST, ']'
        JNE CAPS
        
        LEA DX, MSG_NOCAP  
        JMP DISPLAY
        
        CAPS:
            LEA DX, MSG_FIRST
            
    DISPLAY:
        INT 21H        
        
                  

    
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
            
MAIN ENDP



END MAIN



