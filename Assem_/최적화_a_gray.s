		AREA     GRAY, CODE, READONLY
	
	EXPORT TO_GRAY

TO_GRAY
	
	PUSH		{LR}

	;r0 : rgb_index
	;r1 : gray_index
	
	MOV		r12, r1			; r0, r12 : start rgb_index
	LDR		r9, end_addr	; r1 := 6,220,799
	MOV		r2, #0			; 0?? 0x005EEBFF?? ??
	; r6 will have max value
	; r7 will have min value

Loop1
	LDRB	r3, [r0], #1		; R
	LDRB	r4, [r0], #1		; G
	LDRB	r5, [r0], #1		; B
	BL		MAX_loop			; start

MAX_loop
	CMP		r3, r4
	BLT		loop1				; r3 < r4 : R < G
	BGE		loop2				; r3 >= r4 : R >= G

loop1
	CMP		r4, r5			
	BLT		M_m_RB			; r4 < r5 : G < B : R < G < B
	BGE		loop4				; r4 >= r5 : G >= B

loop4
	CMP		r3, r5			
	BLT		M_m_RG			; r3 < r5 : R < B : R < B < G 
	BGE		M_m_BG			; r3 >= r5 : B < R < G

loop2
	CMP		r3, r5
	BLT		M_m_GB			; r3 < r5 : G < R < B
	BGE		loop3				; r3 >= r5 : B <= R

loop3
	CMP		r4, r5
	BLT		M_m_GR			; r4 < r5 : G < B : G < B < R
	BGE		M_m_BR			; r4 >= r5 : B < G < R

M_m_RB
	MOV		r6, r3
	MOV		r7, r5
	BL		next_loop
M_m_RG
	MOV		r6, r3
	MOV		r7, r4
	BL		next_loop
M_m_GB
	MOV		r6, r4
	MOV		r7, r5
	BL		next_loop
M_m_GR
	MOV		r6, r4
	MOV		r7, r3
	BL		next_loop
M_m_BG
	MOV		r6, r5
	MOV		r7, r4
	BL		next_loop
M_m_BR
	MOV		r6, r5
	MOV		r7, r3
	BL		next_loop

next_loop
	ADD 	r8, r6, r7
	LSR		r8, r8, #1
	STRB	r8, [r12], #1
	ADD		r2, r2, #3
	CMP		r2, r9
	BLT		Loop1
	
	POP		{PC}



end_addr		DCD	0x005EEBFF

            END

