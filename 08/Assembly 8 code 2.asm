


 .MODEL SMALL
 .STACK 100H

 .DATA
   PROMPT          DB  0DH,0AH,'Enter an Algebraic Expression : ',0DH,0AH,'$'
   CORRECT         DB  0DH,0AH,'Expression is Correct.$'
   LEFT_BRACKETS   DB  0DH,0AH,'Too many Left Brackets.$'
   RIGHT_BRACKETS  DB  0DH,0AH,'Too many Right Brackets.$'
   MISMATCH        DB  0DH,0AH,'Bracket Mismatch. Begin Again.$'
   CONTINUE        DB  0DH,0AH,'Type Y if you want to Continue : $'
              
 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     @START:                      ; jump label

     LEA DX, PROMPT               ; load and print the string PROMPT
     MOV AH, 9
     INT 21H

     XOR CX, CX                   ; clear CX

     MOV AH, 1                    ; set input function

     @INPUT:                      ; jump label
       INT 21H                    ; read a character

       CMP AL, 0DH                ; compare AL with CR
       JE @END_INPUT              ; jump to label @END_INPUT if AL=CR

       CMP AL, "["                ; compare AL with "["
       JE @PUSH_BRACKET           ; jump to label @PUSH_BRACKET if AL="["

       CMP AL, "{"                ; compare AL with "{"
       JE @PUSH_BRACKET           ; jump to label @PUSH_BRACKET if AL="{"

       CMP AL, "("                ; compare AL with "("
       JE @PUSH_BRACKET           ; jump to label @PUSH_BRACKET if AL="("

       CMP AL, ")"                ; compare AL with ")"
       JE @ROUND_BRACKET          ; jump to label @ROUND_BRACKET if AL=")"
                                   
       CMP AL, "}"                ; compare AL with "}"
       JE @CURLY_BRACKET          ; jump to label @CURLY_BRACKET if AL="}"

       CMP AL, "]"                ; compare AL with "]"
       JE @SQUARE_BRACKET         ; jump to label @SQUARE_BRACKET if AL="]"

       JMP @INPUT                 ; jump to label @INPUT

       @PUSH_BRACKET:             ; jump label

       PUSH AX                    ; push AX onto the STACK
       INC CX                     ; set CX=CX+1
       JMP @INPUT                 ; jump to label @INPUT

       @ROUND_BRACKET:            ; jump label

       POP DX                     ; pop a value from STACK into DX
       DEC CX                     ; set CX=CX-1

       CMP CX, 0                  ; compare CX with 0
       JL @RIGHT_BRACKETS         ; jump to label @RIGHT_BRACKETS if CX<0

       CMP DL, "("                ; compare DL with "("
       JNE @MISMATCH              ; jump to label @MISMATCH if DL!="("
       JMP @INPUT                 ; jump to label @INPUT
       
       @CURLY_BRACKET:            ; jump label

       POP DX                     ; pop a value from STACK into DX
       DEC CX                     ; set CX=CX-1

       CMP CX, 0                  ; compare CX with 0
       JL @RIGHT_BRACKETS         ; jump to label @RIGHT_BRACKETS if CX<0

       CMP DL, "{"                ; compare DL with "{"
       JNE @MISMATCH              ; jump to label @MISMATCH if DL!="{"
       JMP @INPUT                 ; jump to label @INPUT

       @SQUARE_BRACKET:           ; jump label
                                   
       POP DX                     ; pop a value from STACK into DX
       DEC CX                     ; set CX=CX-1

       CMP CX, 0                  ; compare CX with 0
       JL @RIGHT_BRACKETS         ; jump to label @RIGHT_BRACKETS if CX<0

       CMP DL, "["                ; compare DL with "["
       JNE @MISMATCH              ; jump to label @MISMATCH if DL!="["
     JMP @INPUT                   ; jump to label @INPUT

     @END_INPUT:                  ; jump label

     CMP CX, 0                    ; compare CX with 0
     JNE @LEFT_BRACKETS           ; jump to label @LEFT_BRACKETS if CX!=0

     MOV AH, 9                    ; set string output function

     LEA DX, CORRECT              ; load and print the string CORRECT
     INT 21H                      

     LEA DX, CONTINUE             ; load and print the string CONTINUE
     INT 21H                       

     MOV AH, 1                    ; set input function
     INT 21H                      ; read a character

     CMP AL, "Y"                  ; compare AL with "Y"
     JNE @EXIT                    ; jump to label @EXIT if AL!="Y"
     JMP @START                   ; jump to label @START

     @MISMATCH:                   ; jump label

     LEA DX, MISMATCH             ; load and display the string MISMATCH
     MOV AH, 9                     
     INT 21H

     JMP @START                   ; jump to label @START

     @LEFT_BRACKETS:              ; jump label

     LEA DX, LEFT_BRACKETS        ; load and display the string LEFT_BRACKETS
     MOV AH, 9
     INT 21H

     JMP @START                   ; jump to label @START

     @RIGHT_BRACKETS:             ; jump label

     LEA DX, RIGHT_BRACKETS       ; load and display the string RIGHT_BRACKETS
     MOV AH, 9
     INT 21H

     JMP @START                   ; jump to label @START

     @EXIT:                       ; jump label

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP
 END MAIN