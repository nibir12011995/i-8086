.MODEL SMALL
.STACK 100H


.DATA

    MSG_IN DB 'Enter a string : $'
    MSG_FORWARD DB 0AH,0DH,'forward: $'
    MSG_BACKWARD DB 0AH,0DH,'backward: $'
    
    MSG_PAL DB 0AH,0DH,'palindrome $'
    MSG_NOT_PAL DB 0AH,0DH,'not palindrome $'
    
    FORWARD DB 50 DUP ('$')
    BACKWARD DB 50 DUP ('$')
    
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        
        MOV AH,9
        LEA DX,MSG_IN
        INT 21H
        
        
        MOV AH,1
        LEA SI,FORWARD
        
        XOR CX,CX
        
    INPUT:
        INT 21H
        CMP AL,0DH
        JE INPUT_END
     
        
        ;spa ! "
        CMP AL, 20H
        JE INPUT
        CMP AL, 21H
        JE INPUT
        CMP AL, 22H
        JE INPUT 
        ; ' () *
        CMP AL, 27H
        JE INPUT
        CMP AL, 28H
        JE INPUT 
        CMP AL, 29H
        JE INPUT 
        CMP AL, 2AH
        JE INPUT
        ; , - . / 
        CMP AL, 2CH
        JE INPUT
        CMP AL, 2DH
        JE INPUT
        CMP AL, 2EH
        JE INPUT
        CMP AL, 2FH
        JE INPUT
        ; :
        CMP AL, 3AH
        JE INPUT
        ; ;
        CMP AL, 3BH
        JE INPUT
        ; ?
        CMP AL, 3FH
        JE INPUT
        ; `
        CMP AL, 60H
        JE INPUT
        
        
        PUSH AX
        INC CX
        MOV [SI], AL
        INC SI
        JMP INPUT
        
    INPUT_END:
        LEA DI,BACKWARD
        MOV BX,CX
        
    BACKWARD_STR:
        POP DX
        MOV [DI],DL
        INC DI
        LOOP BACKWARD_STR
        
        
        MOV AH,9
        LEA DX,MSG_FORWARD
        INT 21H
        
        MOV AH,9
        LEA DX,FORWARD
        INT 21H
        
        
        MOV AH,9
        LEA DX,MSG_BACKWARD
        INT 21H
        
        MOV AH,9
        LEA DX,BACKWARD
        INT 21H
        
        CLD
        MOV CX,BX
        LEA SI,FORWARD
        LEA DI,BACKWARD
        
        REPE CMPSW
        JZ PAL
        
        MOV AH,9
        LEA DX,MSG_NOT_PAL
        INT 21H
        
        JMP EXIT
        
    PAL:
        MOV AH,9
        LEA DX,MSG_PAL
        INT 21H
        
    EXIT:
        MOV AH,4CH
        INT 21H  
    
MAIN ENDP
END MAIN