

				AREA    	part1, CODE, READONLY
				THUMB
							
				EXPORT  	screen

screen

start			PROC
				PUSH { R0-R12, LR}
				LDR R0,= 0x20000500 ; cursor
				LDR R1,= 0x20000600 ; battleship
				LDR R2,= 0x20000700 ; civilian
				LDR R3,= 0x20000800 ; send to screen 
				MOV R8, #64
check			LDR R4, [R0], #4
				LDR R5, [R1], #4
				LDR R6, [R2], #4
				AND R7, R5, R4
				ANDS R7, R6			; the AND parts are written for bonus part which is not achieved:)
				BNE abort_mission
				ORR R7, R5, R4		; the ships and cursor are ORR'ed to let the screen contain all
				ORR R7, R6
				STR R7, [R3], #4
				SUBS R8, #1
				BNE check
				; print the memory starting with 0x20000800 to the screen
abort_mission			
				POP	{R0-R12, LR}
				BX	LR
				END