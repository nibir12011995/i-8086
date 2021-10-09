.MODEL SMALL
.STACK 100H


.DATA

    MSG_IN DB 'Enter a string : $'
    
    MSG_Z_OUT DB 10,13, "Z COUNT: $"
    MSG_S_OUT DB 10,13, "S COUNT: $"
    
    STRING DB 50 DUP ('$')
    
    ZCOUNT DB 0
    SCOUNT DB 0
    
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        
        MOV AH,9
        LEA DX,MSG_IN
        INT 21H
        
        
        MOV AH,1
        LEA SI,STRING
        
        XOR CX,CX
        
    INPUT:
        INT 21H
        CMP AL,0DH
        JE INPUT_END
        

        CMP AL, "z"
        JE GO_Z_COUNT
        
        CMP AL, "s"
        JE GO_S_COUNT
        
        PUSH AX
        INC CX
        MOV [SI], AL
        INC SI
        
        JMP INPUT
        
        
        GO_Z_COUNT:
            INC ZCOUNT
            JMP INPUT
        GO_S_COUNT:
            INC SCOUNT
            JMP INPUT    
        
        
    INPUT_END:
        LEA DX, MSG_Z_OUT
        MOV AH,9
        INT 21H
        
        ADD ZCOUNT, 30H
        MOV AH,2
        MOV DL, ZCOUNT
        INT 21H
        
        
        LEA DX, MSG_S_OUT
        MOV AH,9
        INT 21H
        
        ADD SCOUNT, 30H
        MOV AH,2
        MOV DL, SCOUNT
        INT 21H     
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP



END MAIN



