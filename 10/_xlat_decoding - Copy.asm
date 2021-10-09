.MODEL SMALL
.STACK 100H
.DATA 
                           ;    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    CODE_KEY DB 41H DUP(' '),   "XQPOGHZBCADEIJWFMNKLRSTVUY",
             DB 37 DUP(' ')
             
    CODED DB 80 DUP('$')
    CHARS DW 0
    
    MSG_IN DB "ENTER:   $"
    MSG_CODED DB 10,13, "CODED:   $"                      

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
        
        CMP AL, "A"
        JB SKIP
        CMP AL, "a"
        JAE LOWER
        
        JMP XLAT_
        LOWER:
            CMP AL, "z"
            JA SKIP
            SUB AL, 20H
        
        XLAT_:     
            XLAT
        
        SKIP:
            
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
        
        
            
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP       

END MAIN
    