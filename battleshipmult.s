			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		delayy	
			EXTERN		screen
			EXTERN		battlescreen
			EXPORT  	battleship	; Make available,
			
				
			
battleship		PROC
				PUSH		{R0-R12,LR}
				
				LDR	R1,=0x20000000
				LDR	R0, [R1]		; R0 has the number of battle ships placed on screen
				
				
				LDR	R4,=0x20000900
				MOV	R3, #0x100	; R3 gives the shift value to the memory place of battleships
				MUL	R0, R3		; if there are multiple battle ships they are placed seperately to determine the winner
				ADD	R4, R0
				
				UDIV R0, R3		; 
				ADD	R0, #1
				STR	R0, [R1], #4
				
				MOV R5,#0
				SUB R6,R10,#2; column-2	
				SUB R7, R9, #2; row-2
				
st				CMP R5, R6		; column place is gotten by going word by word
				BNE loop
				
				LDR R8,=0x0000001F
shift2			CMP R7,#0	; battleships are places according to row and column data
				BEQ go 		; rows are gotten by shifting the desired shape with the value
				LSL R8,#1
				SUB R7,#1
				B shift2
go				STR R8, [R4], #4	; the desired shape is given to the ship
				STR R8, [R4], #4
				STR R8, [R4,#4]
				STR R8, [R4,#8]
				STR R8, [R4], #12
				ADD R5, #5
loop			LDR R8,= 0x00000000
				STR R8, [R4], #4	; the places different than the ship are stored as zeros
				ADD R5, #1
				CMP R5, #64
				BNE st
				BL 	battlescreen
				BL	screen
				POP		{R0-R12,LR}
				BX 	LR
			
			