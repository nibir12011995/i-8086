 .MODEL SMALL
 .STACK 100H

 .DATA
  
    MSG1   DB  'Average Marks of Students : ',0DH,0AH,'$'

    AVERAGE  DW  4 DUP(0)  
    
     CLASS   DB  'Mary Allen  ',67,45,98,33
             DB  'Scott Baylis',70,56,87,44
             DB  'George Frank',82,72,89,40
             DB  'Sam Wong    ',78,76,92,60 

 .CODE
   MAIN PROC
     MOV AX, @DATA               
     MOV DS, AX
 
                           
     LEA DX,  MSG1             
     MOV AH, 9                     
     INT 21H


     LEA DI, AVERAGE           
     LEA SI, CLASS               
     ADD SI, 12                  
     MOV CX, 4                   

     CALCULATE_AVERAGE:            
       XOR AX, AX                 
       MOV DX, 4                 

       SUM:                     
         XOR BH, BH              
         MOV BL, [SI]             

         ADD AX, BX            

         INC SI                  
         DEC DX                
       JNZ SUM                 

       MOV BX, 4                 
       DIV BX                     

       MOV [DI], AX               
       ADD DI, 2                
       ADD SI, 12                 
     LOOP CALCULATE_AVERAGE        

    
     LEA SI, AVERAGE           
     LEA DI, CLASS               
     MOV CX, 4                    

     RESULT:              
       MOV BX, 12                
       MOV AH, 2                 

       NAME_PRINT:                    
         MOV DL, [DI]             
         INT 21H                  

         INC DI                   
         DEC BX                  
       JNZ NAME_PRINT                  

                         

 
       MOV DL, 20H               
       INT 21H                    

       XOR AH, AH                
       MOV AL, [SI]              

       CALL OUTPUT_DECIMAL                

       MOV AH, 2                  
       MOV DL, 0DH               
       INT 21H                    

       MOV DL, 0AH                
       INT 21H

       ADD SI, 2                 
       ADD DI, 4                 
     LOOP RESULT           

     MOV AH, 4CH                  
     INT 21H
   MAIN ENDP
  
  
  
  

 OUTPUT_DECIMAL PROC

   PUSH BX                        
   PUSH CX                       
   PUSH DX                        

   XOR CX, CX                    
   MOV BX, 10                    

   OUTPUT:                       
     XOR DX, DX                  
     DIV BX                      
     PUSH DX                     
     INC CX                      
     CMP AX,0                   
   JNZ OUTPUT                  

   MOV AH, 2                     

   DISPLAY:                     
     POP DX                     
     OR DL, 30H                  
     INT 21H                     
   LOOP DISPLAY                  

   POP DX                      
   POP CX                         
   POP BX                       

   RET                           
 OUTPUT_DECIMAL ENDP



 END MAIN

