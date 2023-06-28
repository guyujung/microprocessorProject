		AREA     CH_ADDR, CODE, READONLY
	
	EXPORT CHANGE_ADDR

CHANGE_ADDR
		
	PUSH		{LR}
	
	;r0 start_addr
	;r1 new_addr
	LDR		r10, plus_addr
	MOV		r11, r1
	LDR		r12, one_addr
	MOV		r9, r1
	MOV		r6, #0			; count for all pixel byte
	LDR		r7, end_value

lp_start
	MOV		r5, #0
	MOV		r11, r9

loop
	LDRB	r3, [r0], #1
	STRB	r3, [r11], #1
	ADD		r5, r5, #1
	ADD		r6, r6, #1
	CMP		r5, r12
	BLT		loop
	ADD		r9, r9, r10
	CMP		r6, r7
	BLT		lp_start

	POP		{PC}


;start_addr		DCD	0x50000000		; Load addr						
one_addr		DCD	0x1680			; usage for Load
plus_addr		DCD	0x2000			; change new addr
;new_addr		DCD 0x60000000		; new
end_value		DCD	0x005EEC00

            END

