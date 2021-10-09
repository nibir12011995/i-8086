.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB 10,13,10,13, "EXPRESSION:   $"
    
    MSG_RIGHT_MORE DB 10,13, "TOO MANY RIGHT BRACKETS.   $"
    MSG_LEFT_MORE DB 10,13, "TOO MANY LEFT BRACKETS.   $"
    MSG_MISMATCH DB 10,13, "BRACKETS MISMATCH.   $"
    
    MSG_CORRECT DB 10,13,10,13, "CORRECT EXPRESSION. $"
    MSG_AGAIN DB 10,13, "GO AGAIN. y or Y:   $"
     
    
    COUNT DW 0

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    INITIALIZE:
    
        LEA DX, MSG_IN
        MOV AH, 9
        INT 21H
        
        MOV COUNT, 0
        MOV AH, 1
    
    INPUT:
        INT 21H
        
        CMP AL, 0DH
        JE RETURN_INPUT
        
        CMP AL, "("
        JE PUSH_STACK
        CMP AL, "{"
        JE PUSH_STACK
        CMP AL, "["
        JE PUSH_STACK
        
        CMP AL, ")"
        JE END_BRACKET
        CMP AL, "}"
        JE END_BRACKET
        CMP AL, "]"
        JE END_BRACKET
        
        JMP INPUT
        
        PUSH_STACK:
            PUSH AX
            INC COUNT
            JMP INPUT
            
            
        END_BRACKET:  
            POP DX
            DEC COUNT
            
            CMP COUNT, 0
            JL RIGHT_MORE
            
            
            CMP AL, ")"
            JE FIRST_BRACKET
            CMP AL, "}"
            JE SECOND_BRACKET
            CMP AL, "]"
            JE THIRD_BRACKET
            
            FIRST_BRACKET: 
                CMP DL, "("
                JNE MISMATCH
                JMP INPUT    
        
            SECOND_BRACKET:  
                CMP DL, "{"
                JNE MISMATCH
                JMP INPUT
                    
            THIRD_BRACKET:             
                CMP DL, "["
                JNE MISMATCH
                JMP INPUT
    
    RETURN_INPUT:
        CMP COUNT, 0
        JG LEFT_MORE
         
        LEA DX, MSG_CORRECT
        MOV AH,9
        INT 21H
        
        LEA DX, MSG_AGAIN
        MOV AH,9
        INT 21H
        
        
        AGAIN:
            MOV AH, 1
            INT 21H
            CMP AL, "Y"
            JE INITIALIZE
            CMP AL, "y"
            JE INITIALIZE
            
            JMP EXIT
        
    
    LEFT_MORE:
        LEA DX, MSG_LEFT_MORE
        MOV AH, 9
        INT 21H
        JMP INITIALIZE
            
    RIGHT_MORE:
        LEA DX, MSG_RIGHT_MORE
        MOV AH, 9
        INT 21H
        JMP INITIALIZE
        
    MISMATCH:
        LEA DX, MSG_MISMATCH
        MOV AH, 9
        INT 21H
        JMP INITIALIZE          
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP



END MAIN





