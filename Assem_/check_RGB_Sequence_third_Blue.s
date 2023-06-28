		AREA     CHECK_B, CODE, READONLY
	
	EXPORT CHECK_B_DEL_RG

CHECK_B_DEL_RG
		
	PUSH		{LR}
	
	LDR		r0, start_addr
	LDR		r11, start_addr
	LDR		r12, end_addr
	MOV		r5, #0

Loop
	MOV		r1, #0
	BL		loop2
Label1
	ADD		r1, r1, #1
	BL		loop3
Label2
	ADD		r1, r1, #1
	BL		loop1
Label3
	ADD		r5, r5, #3
	CMP		r5, r12
	BLT		Loop
	BL		endloop


loop1
	LDRB	r2, [r0], #1
	STRB	r2, [r11], #1
	BL		Label3
loop2
	MOV		r3, #0
	ADD		r0, r0, #1
	STRB	r3, [r11], #1
	BL		Label1
loop3
	MOV		r4, #0
	ADD		r0, r0, #1
	STRB	r4, [r11], #1
	BL		Label2


endloop
	POP		{PC}


start_addr		DCD	0x40000000		; ??? ??? ??? ??? ?? ??? ??
							; ??? r0? ?? ????? ??
end_addr		DCD	0x005EEBFF

            END

