.MODEL SMALL
.STACK 100H
.DATA 
                           ;    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    CODE_KEY DB 41H DUP(' '),   "XQPOGHZBCADEIJWFMNKLRSTVUY",
             DB 37 DUP(' ')                            
    DECODE_KEY DB 41H DUP(' '), "JHIKLPEFMNSTQRDCBUVWYXOAZG",
             DB 37 DUP(' ')
             
    CODED DB 80 DUP('$')
    DECODED DB 80 DUP('$')
    CHARS DW 0
    
    MSG_IN DB "ENTER:   $"
    MSG_CODED DB 10,13, "CODED:   $"
    MSG_DECODED DB 10,13, "DECODED: $"                     

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX, MSG_IN
    MOV AH, 9
    INT 21H
    
    ;================ CODED =================
    
    LEA BX, CODE_KEY
    LEA DI, CODED
    
    DO:
        MOV AH, 1 
        INT 21H
        
        CMP AL, 0DH
        JE END_INPUT
        
        XLAT
        
        MOV [DI], AL
        INC DI
        INC CHARS
        JMP DO
        
    
    END_INPUT:
        
        LEA DX, MSG_CODED
        MOV AH,9
        INT 21H
        
        LEA DX, CODED
        MOV AH, 9
        INT 21H
            
    ;================ DECODE ===============
    
    LEA BX, DECODE_KEY
    LEA SI, CODED
    LEA DI, DECODED
    MOV CX, CHARS
    CLD 
    
    DECODE:
        LODSB
        
        XLAT
        
        MOV [DI], AL
        INC DI
        
        LOOP DECODE
        
    PRINT_DECODEC:
        
        LEA DX, MSG_DECODED
        MOV AH,9
        INT 21H
        
        LEA DX, DECODED
        MOV AH, 9
        INT 21H    
        
    
    
    
        
    
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP

INCLUDE OUTDEC.ASM 


END MAIN