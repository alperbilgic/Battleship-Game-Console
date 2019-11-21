			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		delayy	
			EXTERN		screen
			EXPORT  	battleship	; Make available,
			
				
			
battleship		PROC
				PUSH		{R0-R12,LR}
				
				MOV	R2,R9
				MOV	R3,R10
				LDR R4,=0x20000600
				MOV R5,#0
				SUB R6,R3,#2; column-2
				SUB R7, R2, #2; row-2
				
st				CMP R5, R6		; save screen page
				BNE loop
				
				LDR R8,=0x0000001F
shift2			CMP R7,#0
				BEQ go 
				LSL R8,#1
				SUB R7,#1
				B shift2
go				STR R8, [R4], #4
				STR R8, [R4], #4
				STR R8, [R4,#4]
				STR R8, [R4,#8]
				STR R8, [R4], #12
				ADD R5, #5
loop			LDR R8,= 0x00000000
				STR R8, [R4], #4
				ADD R5, #1
				CMP R5, #64
				BNE st
				BL	screen
				POP		{R0-R12,LR}
				BX 	LR
			
			