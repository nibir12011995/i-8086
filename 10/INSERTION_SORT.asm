.MODEL SMALL
 .STACK 100H

 .DATA
   ARRAY  DB  100 DUP(?)

 .CODE
   MAIN PROC
     MOV AX, @DATA             
     MOV DS, AX

     LEA SI, ARRAY               
     XOR BX, BX                 

     INPUT:                     
       MOV AH, 2                
       MOV DL, "?"               
       INT 21H                    

       MOV AH, 1                 
       INT 21H                  

       CMP AL, 1BH               
       JE END_INPUT             

       MOV CX, BX                
       JCXZ NOT_PRESENT          

       PUSH SI                    
       LEA SI, ARRAY            

       COMPARE:                
         MOV DL, [SI]           

         CMP AL, DL             
         JE ALREADY_PRESENT     

         INC SI                  
       LOOP COMPARE            

       JMP NOT_PRESENT        

       ALREADY_PRESENT:        
       POP SI                     
       JMP SKIP_INPUT            

       NOT_PRESENT:             
       INC BX                   
       MOV [SI], AL              
       INC SI                   

       SKIP_INPUT:              

       MOV AH, 2                 
       MOV DL, 0DH               
       INT 21H                    

       MOV DL, 0AH                
       INT 21H                    

       PUSH SI                   

       LEA SI, ARRAY             

       CALL SORT_FUNC          

       LEA SI, ARRAY             

       CALL PRINT_ARRAY          

       POP SI                    

       MOV AH, 2                  
       MOV DL, 0DH               
       INT 21H                    

       MOV DL, 0AH              
       INT 21H                    

       JMP INPUT               

     END_INPUT:                 

     MOV AH, 4CH                 
     INT 21H
   MAIN ENDP



 PRINT_ARRAY PROC

   PUSH AX                      
   PUSH CX                      
   PUSH DX                       

   MOV CX, BX                    
   MOV AH, 2                    

   @PRINT_ARRAY:                
     MOV DL, [SI]               
     INT 21H           
     MOV DL, ' '               
     INT 21H                        

     INC SI                       
   LOOP @PRINT_ARRAY              

   POP DX                      
   POP CX                       
   POP AX                       

   RET                           
 PRINT_ARRAY ENDP



 SORT_FUNC PROC

   PUSH AX                       
   PUSH BX                       
   PUSH CX                        
   PUSH DX                      
   PUSH DI                  

   MOV AX, SI                    
   MOV CX, BX                    

   CMP CX, 1                      
   JLE SKIP_SORTING           

   DEC CX                        

   OUTER_LOOP:           
     MOV BX, CX            
     MOV SI, AX           
     MOV DI, AX                 
     INC DI                      

     INNER_LOOP:              
       MOV DL, [SI]             

       CMP DL, [DI]              
       JNL SKIP_EXCHANGE        

       XCHG DL, [DI]             
       MOV [SI], DL               

       SKIP_EXCHANGE:           
       INC SI                    
       INC DI                   

       DEC BX                   
     JNZ INNER_LOOP              
   LOOP OUTER_LOOP              

   SKIP_SORTING:                

   POP DI                        
   POP DX                       
   POP CX                     
   POP BX                       
   POP AX                        

   RET                          
 SORT_FUNC ENDP


 END MAIN