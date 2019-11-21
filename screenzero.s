				AREA    	part1, CODE, READONLY
				THUMB
							
				EXPORT  	screenzero

screenzero

start			PROC
				PUSH	{R0-R12, LR}
				MOV	R0, #0
				LDR	R3,=0x20000000
				STR	R0, [R3]
				LDR R3,=0x20000500 ; send to screen 
				MOV R8, #0x400
fill			STR R0, [R3], #4	; the memory places that are used to place ships and cursors are loaded with zeros first
				SUB	R8, #1
				CMP	R8, #0
				BNE fill
				POP	{R0-R12, LR}
				BX	LR
				ENDP