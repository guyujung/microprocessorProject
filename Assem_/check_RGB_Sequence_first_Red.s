		AREA     CHECK_R, CODE, READONLY
	
	EXPORT CHECK_R_DEL_GB

CHECK_R_DEL_GB
		
	PUSH		{LR}
	
	LDR		r0, start_addr
	LDR		r11, start_addr
	LDR		r12, end_addr
	MOV		r5, #0

Loop
	MOV		r1, #0
	BL		loop1
Label1
	ADD		r1, r1, #1
	BL		loop2
Label2
	ADD		r1, r1, #1
	BL		loop3
Label3
	ADD		r5, r5, #3
	CMP		r5, r12
	BLT		Loop
	BL		endloop


loop1
	LDRB	r2, [r0], #1
	STRB	r2, [r11], #1
	BL		Label1
loop2
	MOV		r3, #0
	ADD		r0, r0, #1
	STRB	r3, [r11], #1
	BL		Label2
loop3
	MOV		r4, #0
	ADD		r0, r0, #1
	STRB	r4, [r11], #1
	BL		Label3


endloop
	POP		{PC}


start_addr		DCD	0x40000000		; ??? ??? ??? ??? ?? ??? ??
							; ??? r0? ?? ????? ??
end_addr		DCD	0x005EEBFF

            END

