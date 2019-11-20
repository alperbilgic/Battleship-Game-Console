

				AREA    	part1, CODE, READONLY
				THUMB
							
				EXPORT  	screen2

screen2

start			PROC
				PUSH { R0-R12, LR}
				LDR R0,= 0x20000D00 ; cursor
				LDR R1,= 0x20000E00 ; mines
				LDR	R3,= 0x20000F00	; screen
				
				MOV R8, #64		; the screen of second player is gotten by combining values of cursor and mine memories
check			LDR R4, [R0], #4
				LDR R5, [R1], #4
				ORR R7, R5, R4
				STR R7, [R3], #4
				SUBS R8, #1
				BNE check
				; print the memory starting with 0x20000F00 to the screen
abort_mission			
				POP	{R0-R12, LR}
				BX	LR
				END