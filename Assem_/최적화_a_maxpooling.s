   AREA     MPOOLING, CODE, READONLY
   
   EXPORT MAXPOOLING

MAXPOOLING
   LDR		r0, START_ADDR
   LDR		r1, END_ADDR
   MOV		r2, #0   ;count row
   MOV		r3, #0   ;count col
   MOV      r4, #0   ;initialize second row in kernel
   MOV		r11, #1920   ;issue of immediate value at line 31
   MOV		r12, #512    ;issue of immediate value at line 35
   ADD		r5, r12, #27  ;r5 = 541
   
LOAD_MAX
   
   LDRB   	r6, [r0]
   LDRB		r7, [r0 , #1]
   ADD		r4, r0, r12, LSL #4   ;second row = first row + 8192
   LDRB		r8, [r4]
   LDRB		r9, [r4, #1]
   
   BL		LOOP_MAX
   
STORE   
   STRB		r10, [r1]
   ADD		r1, r1, #1   ;store addr 1 step up
   
   ADD		r2, r2, #2       ;plus 2 until row end
   ADD		r0, r0, #2   ;change row addr
   CMP		r2, r11
   BLT		LOAD_MAX
   BEQ		COMPUTE_COL_ADDR

COMPARE_END
   CMP		r3, r5
   BLE		LOAD_MAX
   BGT		END_MAX_POOLING
   

   
COMPUTE_COL_ADDR
   ADD		r3, r3, #1
   ADD		r0, r0, r12, LSL #5   ; 8192 + 8192 - 1920
   SUB		r0, r0, r11
   MOV		r2, #0
   BL		COMPARE_END
  
   
   
LOOP_MAX
   MOV   r10, r6      ; int max = num1
   CMP   r10, r7      ; if(num2>max)
   BLT   max_num2   ; max=num2
LOOP_MAX_1
   CMP   r10, r8      ; if(num3>max)
   BLT   max_num3   ; max=num3
LOOP_MAX_2
   CMP   r10, r9      ; if(num4>max)
   BLT   max_num4   ; max=num4
   B     STORE      ; max=num1

max_num2
   MOV   r10, r7
   BL   LOOP_MAX_1

max_num3
   MOV   r10, r8
   BL   LOOP_MAX_2

max_num4
   MOV   r10, r9
   B    STORE




END_MAX_POOLING
   POP		{PC}    
   
			
 

START_ADDR   DCD 0x70000000
END_ADDR     DCD 0x80000000
	
		   END