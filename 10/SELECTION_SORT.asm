SELECTION_SORT PROC NEAR
    
    ;input: SI = arr
    ;       BX = number of elements
    
    ;output: SI -> sorted arr
    
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    DEC BX
    JE END_SORT
    
    ;arr -> DX
    MOV DX, SI
    ;for N-1 times do
    SORT_LOOP:
        ;SI changed. initialize again -> first el.
        MOV SI, DX
        
        ;(n-1) (n-2)...(n-n)
        MOV CX, BX
        
        ;SI , DI  --> first el.
        MOV DI, SI
        
        ;let first el. is big. DI -> big 
        ;big -> AL
        MOV AL, [DI]
        
        FIND_BIG:
            ADD SI, 2
            CMP [SI], AL
            JNG NEXT
            
            ;big found ... DI -> big  SI++
            MOV DI, SI
            MOV AL, [DI]
            
            NEXT:
                LOOP FIND_BIG
            
            ;SI -> last element   DI-> big
            ;last <-> big
            CALL SWAP
            ;(n-1) (n-2)...(n-n)
            DEC BX
            JNE SORT_LOOP
            
    END_SORT:
        POP SI
        POP DX
        POP CX
        POP BX
        
        RET        
        
SELECTION_SORT ENDP        
 

SWAP PROC
    ;swaps two array elements
    ;input: SI = one element  (LAST ELEMENT HERE)
    ;       DI = other element
    
    ;output: SI = other , DI = one
    
    PUSH AX
    MOV AL, [SI]
    XCHG AL, [DI]
    MOV [SI], AL
    POP AX
    RET
SWAP ENDP                        