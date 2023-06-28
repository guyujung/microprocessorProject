		AREA     CH_ADDRR, CODE, READONLY
	
	EXPORT CHANGE_ADDR2

CHANGE_ADDR2
		
	PUSH		{LR}
	
	;r0 read_addr
	;r1 write_addr
	MOV		r3, #0		; i=0
	MOV		r12, #0		; j=0
	MOV		r11, #0		; count=0
	LDR		r10, one_array ; for count comp
	LDR		r9, loop_value
	
Loop	
	ADD		r4, r0, r3	; r4 : read+i
	LDRB	r5,	[r4]	; r5(x) = *(read+i)
	CMP		r11, r10
	BEQ		sub_loop1
return_loop
	ADD		r6, r1, r12	; r6 : write+j
	STRB	r5, [r6]
	ADD		r3, r3, #1
	ADD		r12, r12, #1
	ADD		r11, r11, #1
	CMP		r3, r9
	BLT		Loop
	BL 		end_loop

sub_loop1
	MOV		r11, #0		; count=0
	ADD		r12, r12, #0x1880 ; j+=0x1880
	BL		return_loop

end_loop
	POP		{PC}


;start_addr		DCD	0x50000000		; Load addr						
one_addr		DCD	0x1680			; usage for Load
plus_addr		DCD	0x2000			; change new addr
;new_addr		DCD 0x60000000		; new
end_value		DCD	0x005EEC00
one_array		DCD 0x780
loop_value		DCD	0x1FA400
            END

