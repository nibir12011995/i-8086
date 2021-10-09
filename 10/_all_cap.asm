.MODEL SMALL
.STACK 100H
.DATA



    MSG_IN DB 'ENTER line of text : $'
    MSG_OUT DB 0DH,0AH ,'Converted :   ','$'   

    COMPARE DB 61h DUP('$'),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
    FINAL_RES DW 50 DUP ('$')  


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG_IN
    MOV AH,9
    INT 21H

    LEA BX,COMPARE
    LEA SI,FINAL_RES
    XOR CX,CX  
    
    INPUT_LOOP:
    
       MOV AH,1
       INT 21H 
       
       CMP AL,0DH
       JE OUTPUT_LOOP  
       
       CMP AL,'a'
       JB PASS_FINAL_RES 
       
       CMP AL,'z'
       JA PASS_FINAL_RES  
       
       INC CX
       XLAT
       PASS_FINAL_RES:
       
         XOR AH,AH
         MOV [SI],AX
         ADD SI,1         
         
    JMP INPUT_LOOP
    
    
  OUTPUT_LOOP:

    MOV AH,9
    LEA DX,MSG_OUT
    INT 21H 
    
    
    MOV AH,9
    LEA DX,FINAL_RES
    INT 21H
  MOV AH,4CH
  INT 21H
END MAIN