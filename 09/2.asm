.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter  M = $'
    MSG2 DB 10,13,'Enter  N = $'
    MSG3 DB 10,13,'GCD = $'


.CODE
MAIN PROC   
    
    MOV AX,@DATA 
    MOV DS,AX
    
    LEA DX,MSG1  
    MOV AH,9
    INT 21H
    
    CALL INPUT_PROC  
    PUSH AX 
    LEA DX,MSG2 
    MOV AH,9
    INT 21H
    CALL INPUT_PROC 
    MOV BX,AX  
    POP AX   


    DIV_PROCESS:  

        XOR DX,DX  
        DIV BX 
        CMP DX,0  
        JE GO_OUT  
        MOV AX,BX  
        MOV BX,DX  
        JMP DIV_PROCESS 

 
    GO_OUT:  

        LEA DX,MSG3 
        MOV AH,9
        INT 21H
        
        MOV AX,BX  
        CALL OUTPUT_PROC 
         
MOV AH,4CH  
INT 21H
MAIN ENDP


         
         
INPUT_PROC PROC  
    
    PUSH BX  
    PUSH CX 
    PUSH DX  
    JMP START_INPUT   
    

    START_INPUT:
        XOR BX,BX  
        XOR CX,CX  
        XOR DX,DX  
        MOV AH,1  
        INT 21H  
        
        JMP INPUT_CLOSE  


    INPUT:

        MOV AH,1  
        INT 21H   
        
    INPUT_CLOSE: 

        CMP AL,0DH  
        JE END_INPUT  
        
        JNE OK
        CMP CH,0  
        JNE REMOVE_MINUS   
        
         
        JMP MOVE_BACK  

    REMOVE_MINUS: 
        CMP CH,1 
        JNE REMOVE_PLUS  
        CH!=1
        CMP CL,1 
        JE REMOVE_SIGN   


    REMOVE_PLUS:  
        CMP CL,1  
        JE REMOVE_SIGN  
        JMP MOVE_BACK   


    REMOVE_SIGN:
 
        JMP START_INPUT 


    MOVE_BACK: 

        MOV AX,BX  
        MOV BX,10  
        DIV BX  
        MOV BX,AX  
        XOR DX,DX  
        DEC CL 
        JMP INPUT   

    OK:

        INC CL 
        CMP AL,30H  
        JL ERROR 
        CMP AL,39H  
        JG ERROR  
        AND AX,000FH  
        PUSH AX  
        MOV AX,10 
        MUL BX ; AX=AX*BX
        MOV BX,AX  
        POP AX  
        ADD BX,AX  
        JS ERROR 
        JMP INPUT 
   
    ERROR:   

        MOV AH,2
        INT 21H 
        XOR CH,CH  

    CLEAR: 

        MOV DL,8H  
        INT 21H  
        MOV DL,20H   
        INT 21H  
        MOV DL,8H  
        INT 21H 
        LOOP CLEAR  
        JMP START_INPUT   


    END_INPUT:  

        CMP CH,1  
        JNE EXIT  

    EXIT:

        MOV AX,BX  
        POP DX  
        POP CX  
        POP BX  
        RET  
INPUT_PROC ENDP
                     
                     
                     

OUTPUT_PROC PROC
        PUSH BX  
        PUSH CX  
        PUSH DX  
        CMP AX,0  
        JGE START  
        PUSH AX  
         
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
        JNE OUTPUT ;ZF=0
        MOV AH,2  
    

    DISPLAY:
        POP DX  
        OR DL,30H  
        INT 21H  
        LOOP DISPLAY  
        POP DX  
        POP CX  
        POP BX  
        RET 
OUTPUT_PROC ENDP

END MAIN
