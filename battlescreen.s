			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		delayy	
			EXTERN		screen
			EXPORT  	battlescreen	; Make available,
			
				
			
battlescreen	PROC
				PUSH		{R0-R12,LR}
				
				LDR R0,= 0x20000900 ; cursor
				
				LDR R3,= 0x20000600 ; will have the map of battleships together
				MOV R8, #64
check			LDR R1, [R0]
				ADD R0, #0x100
				LDR	R2, [R0]
				ADD R0, #0x100
				LDR	R4, [R0]
				ADD R0, #0x100
				LDR	R5, [R0]
				SUB	R0, #0x300
				ADD R0, #0x04
				ORR R7, R2, R1
				ORR R7, R4
				ORR R7, R5
				STR R7, [R3], #4
				SUBS R8, #1
				BNE check
				; the battleships are collected together to the space between 0x20000600-0x20000700
				
abort_mission			
				
				
				POP		{R0-R12,LR}
				BX 	LR