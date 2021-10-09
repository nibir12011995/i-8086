.MODEL SMALL
.STACK 100H

.DATA

    MSG_IN DB "ENTER:   $"
    
    MSG_VOWEL DB 10,13,10,13, "VOWEL:   $"
    MSG_CON DB 10,13, "CONSONANT:  $" 

    STRING DB 80 DUP(0)
    VOWEL DB 'AEIOU'
    CONSONANT DB 'BCDFGHJKLMNPQRSTVWXYZ'
    CHARS DW 0
    
    
    VCOUNT DW 0
    CCOUNT DW 0
    
.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    LEA DX, MSG_IN
    MOV AH,9
    INT 21H
    
    LEA DI, STRING 
    CALL READ_STR
    MOV CHARS, BX
    
    
    ;--------------------------------------
    
    CLD
    
    LEA SI, STRING
    MOV BX, CHARS
    
    REPEAT:
        LODSB
        LEA DI, VOWEL
        MOV CX, 5
        REPNE SCASB   
        JNE CON_COUNT  ;ZF=0 not found CX=0
        
        ;ZF=1 found 
        VOWEL_COUNT:
            INC VCOUNT
            JMP END_REPEAT
            
        CON_COUNT:
            LEA DI, CONSONANT 
            MOV CX, 21
            REPNE SCASB
            JNZ END_REPEAT  ; ZF=0 not found CX=0
            
            ;ZF=1 found
            INC CCOUNT
             
        
        END_REPEAT:
            DEC BX
            JNZ REPEAT
    
    
    LEA DX, MSG_VOWEL
    MOV AH,9
    INT 21H
    MOV AX , VCOUNT 
    CALL OUTDEC
    
    LEA DX, MSG_CON
    MOV AH,9
    INT 21H
    MOV AX, CCOUNT
    CALL OUTDEC
    
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
MAIN ENDP

INCLUDE READ_STR.ASM
INCLUDE PRINT_STR.ASM
INCLUDE OUTDEC.ASM                
                

END MAIN



