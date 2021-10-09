.MODEL SMALL
.STACK 100H

.DATA 

    MSG_IN DB 'Enter string : $'
    MSG_S DB 10,13,'Enter S : $'
    MSG_N DB 10,13,'Enter N : $'
    
    MSG_OUT DB 10,13,'Result : $'
    STRING DB 80
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV ES,AX
    MOV DS,AX
            
    MOV AH,9
    LEA DX,MSG_IN
    INT 21H
                
    MOV AH,1
    LEA SI,STRING  
   
        
    XOR CX,CX
             
    LOOP_INP:
        INT 21H
        
        CMP AL,0DH
        JE LOOP_END_INP
        
        MOV [SI], AL
        INC SI
        INC CX
        JMP LOOP_INP
        
    LOOP_END_INP:
        
        LEA DX,MSG_S
        MOV AH,9
        INT 21H        
        CALL INT_INP
         
        MOV BX,AX
                
        LEA DX,MSG_N
        MOV AH,9
        INT 21H        
        CALL INT_INP
        
               
        CALL DELETE
        
         
        
        
    MOV AH,4CH
    INT 21H
MAIN ENDP



INT_INP PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    START:
        XOR BX,BX
        XOR CX,CX
        MOV AH,1
        INT 21H
        
    LOOP_INT:
        CMP AL,'0'
        JL NOT_INT
        
        CMP AL,'9'
        JG NOT_INT
        
        AND AX,000FH
        PUSH AX
        MOV AX,10
        MUL BX
        POP BX
        ADD BX,AX
        
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JNE LOOP_INT
        MOV AX,BX 
        
    EXIT:
        POP DX
        POP CX
        POP BX
        RET 
        
    NOT_INT:
        MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H
        JMP START
        RET
INT_INP ENDP
      
      
DELETE PROC
        
        CLD
   
        LEA DI,STRING
        ADD DI,BX
        
        ADD AX,BX
        SUB CX,AX
      
        LEA SI,STRING

        ADD SI,AX
        REP MOVSB
        
        MOV [DI],'$'
        
        MOV AH,9
        LEA DX,MSG_OUT
        INT 21H
        
        PRINT_RES_STR:
            MOV AH,9
            LEA DX,STRING
            INT 21H
        
DELETE ENDP

END MAIN