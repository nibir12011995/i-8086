
.MODEL SMALL
.STACK 100H

.DATA  

    MSG1 DB 'Enter the time in seconds up to 65535 = $\'
    MSG2 DB 0DH,0AH,'Time in hh:mm:ss format = $\'
    SPACE DB ' : $\'    
    
.CODE 

MAIN PROC 
    
    MOV AX,@DATA 
    MOV DS,AX
    
    
    LEA DX,MSG1 
    MOV AH,9
    INT 21H
    
    CALL INDEC
    PUSH AX
    
     
    LEA DX,MSG2 
    MOV AH,9
    INT 21H

    POP AX 
    XOR DX,DX 
    MOV CX,3600 
    DIV CX 
    
    CMP AX,10 
    JGE HOURS 
    PUSH AX 
    MOV AX,0 
    CALL OUTPUT_PROC 
    POP AX 


    HOURS: 
    
        CALL OUTPUT_PROC 
        MOV AX,DX 
        PUSH AX 
        LEA DX,SPACE 
        MOV AH,9
        INT 21H
        
        POP AX 
        XOR DX,DX 
        MOV CX,60 
        DIV CX
        CMP AX,10 
        JGE MINUTES 
        PUSH AX 
        MOV AX,0 
        CALL OUTPUT_PROC 

        POP AX 


    MINUTES:    

        CALL OUTPUT_PROC 
        MOV BX,DX 
        LEA DX,SPACE 
        MOV AH,9
        INT 21H
        
        MOV AX,BX 
        CMP AX,10 
        JGE SECONDS 
        PUSH AX 
        MOV AX,0 
        CALL OUTPUT_PROC 
        POP AX


    SECONDS:    

        CALL OUTPUT_PROC
        
         
MOV AH,4CH 
INT 21H
MAIN ENDP




INDEC PROC
    ;to use BX save prev. val
    PUSH BX
    XOR BX,BX
     
    MOV AH,1 
    INT 21H 
    
    JMP END_INDEC 


    INPUT_INDEC:     
    
        MOV AH,1 
        INT 21H  
    
    END_INDEC:    
    
        CMP AL,0DH 
        JE EXIT_INDEC                            
     
    
    AND AX,000FH 
    PUSH AX 
    MOV AX,10 
    MUL BX 
    MOV BX,AX
    POP AX 
    ADD BX,AX 
    
    JMP INPUT_INDEC 


    EXIT_INDEC:

        MOV AX,BX
        POP BX ; retain prev. value 
        RET 
INDEC ENDP




OUTPUT_PROC PROC 
    
    PUSH BX 
    PUSH CX 
    PUSH DX
     
    CMP AX,0 
    JGE START
     
    PUSH AX 
    MOV AH,2 
    
    INT 21H 
    POP AX 
 

    START:       

        XOR CX,CX
        MOV BX,10 
        
        
    OUTPUT:
        XOR DX,DX 
        DIV BX
        PUSH DX 
        INC CX 
        OR AX, AX
        JNE OUTPUT 
        MOV AH,2 


    DISPLAY:      

        POP DX 
        OR DL, 30H 
        INT 21H 
        
        LOOP DISPLAY 
        POP DX 
        POP CX 
        POP BX 
        RET
OUTPUT_PROC ENDP

END MAIN
