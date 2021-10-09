.MODEL SMALL
.STACK 100H
.DATA
      ;SUBJECT  A  B  C  D         

      SCORES DW 67,45,98,33  ;student 1
             DW 70,56,87,44  ;        2
             DW 82,72,89,40  ;        3
             DW 80,67,95,50  ;        4
             DW 78,76,92,60  ;        5  
             ;   |  |  |  |
             
      AVG DW 4 DUP(0)
      DIVISOR DW 5     
    


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ;(4-1)x2 = 6
    ;starting from el. 4
    MOV SI, 6   
    
    REPEAT:
        MOV CX, 5
        XOR BX, BX
        XOR AX, AX
        
        FOR:
            ADD AX, SCORES[SI + BX]
            ADD BX, 8
            LOOP FOR
        
        XOR DX, DX   ; remainder holder clean
        DIV DIVISOR  ; AX / 5
        
        MOV AVG[SI], AX
        SUB SI, 2
        
        ;=========== UNTIL J=0 LOOP ===========
        JNL REPEAT  
        ;======================================
        
   
   
   
   ;-----------AVG PRINT-------------
   LEA SI, AVG
   MOV CX, 4
   AVG_PRINT: 
        MOV AX, [SI]
        CALL OUTDEC
        
        ;SPACE
        MOV DL, 20H
        MOV AH, 2
        INT 21H
        
        ADD SI, 2
        LOOP AVG_PRINT   
    
        
    
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP


INCLUDE OUTDEC.ASM

END MAIN