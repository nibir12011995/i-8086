.MODEL SMALL
.STACK 100H
.DATA 
      ;ROW AVERAGE
      
      ;SUBJECT  A  B  C  D         

      SCORES DW 67,45,98,33  ;student 1  --
             DW 70,56,87,44  ;        2  --
             DW 82,72,89,40  ;        3  --
             DW 80,67,95,50  ;        4  --
             DW 78,76,92,60  ;        5  --
             
             
      AVG DW 5 DUP(0)
      DIVISOR DW 4     
      
      LOOP_COUNTER DW 0


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ;start from el. 1
    MOV SI, 0
    MOV LOOP_COUNTER, 5    ;  elements in avg.
    LEA DI, AVG
    REPEAT:
        MOV CX, 4
        XOR BX, BX
        XOR AX, AX
        
        FOR:
            ADD AX, SCORES[SI]
            ADD SI, 2
            LOOP FOR
            
        
        XOR DX, DX
        DIV DIVISOR   ; AX / 4
        
        
        MOV [DI], AX
        ADD DI, 2
        
        DEC LOOP_COUNTER
        ;UNTIL J=0
        JNL REPEAT
        
            
    ;--------------AVG PRINT---------------
    
    MOV CX, 5    ; elements in avg.
    LEA SI, AVG
    AVG_PRINT:
        MOV AX, [SI]
        CALL OUTDEC
        ADD SI, 2
        
        ;SPACE
        MOV DL, 20H
        MOV AH, 2
        INT 21H
        
        LOOP AVG_PRINT    
        
        
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP

                                      
                                      
INCLUDE OUTDEC.ASM

END MAIN