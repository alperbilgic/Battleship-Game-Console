				AREA    	part1, CODE, READONLY
				THUMB
							
				EXPORT  	newscreenzero

newscreenzero

start			PROC
				PUSH	{R0-R12, LR}
				MOV R0, #0x00
				LDR R3,=0x20001000 ; send to screen 
				MOV R8, #0x40
fill			STR R0, [R3], #4	; the memory place for zero screen is created (will be sent while waiting for 0.5 sec)
				SUB	R8, #1
				CMP	R8, #0
				BNE fill
				POP	{R0-R12, LR}
				BX	LR
				ENDP