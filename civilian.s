			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		delayy	
			EXTERN 		screen
			EXPORT  	civilian	; Make available,
			
				
			
civilian		PROC
				PUSH		{R0-R12,LR}
			
				MOV	R2,R9
				MOV	R3,R10
				LDR R4,=0x20000700
				MOV R5,#0
				SUB R6,R3,#2; column-2
				SUB R7, R2, #2; row-2
				
st				CMP R5, R6		; save screen's address
				BNE loop
				
				LDR R8,=0x0000001F
				LDR	R1,=0x00000011
				MOV	R0,#0x00
shift2			CMP R7,#0		; the vertical lines are gotten by shifting the values for location value of rows times
				BEQ go 
				LSL R8,#1
				LSL	R1,#1
				SUB R7,#1
				B shift2
go				LDR	R0, [R4]	; the desired shape is given to civilian ships
				ORR R8, R0
				STR R8, [R4], #4
				LDR	R0, [R4]
				ORR R1, R0
				STR R1, [R4], #4
				LDR	R0, [R4]
				ORR R1, R0
				STR R1, [R4,#4]
				LDR	R0, [R4]
				ORR R8, R0
				STR R8, [R4,#8]
				LDR	R0, [R4]
				ORR R8, R0
				STR R8, [R4], #12
				ADD R5, #5
loop			MOV	R8, #0x00			
				LDR	R0, [R4]
				ORR R8, R0
				STR R8, [R4], #4		; zeros are places by orrin values not to loose the ships placed before		
				ADD R5, #1
				CMP R5, #64
				BNE st
				BL	screen			; screen is placed to related memory space to get values
				POP		{R0-R12,LR}
				BX 	LR
				ENDP
			
			