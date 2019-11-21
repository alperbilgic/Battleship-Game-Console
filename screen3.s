

				AREA    	part1, CODE, READONLY
				THUMB
							
				EXPORT  	screen3

screen3

start			PROC
				PUSH { R0-R12, LR}
				
				LDR R1,= 0x20000600 ; battleship
				LDR R2,= 0x20000700 ; civilian
				LDR R3,= 0x20000800 ; send to screen 
				MOV R8, #64
check			
				LDR R5, [R1], #4	; the screen to be sent for 0.5 sec is gotten by combining data of all ships
				LDR R6, [R2], #4
				ORR R7, R5, R6
				STR R7, [R3], #4
				SUBS R8, #1
				BNE check
				; print the memory starting with 0x20000800 to the screen
			
				POP	{R0-R12, LR}
				BX	LR
				END