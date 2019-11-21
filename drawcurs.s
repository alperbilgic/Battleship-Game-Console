Data		EQU			0x20000001

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			
				
			EXPORT  	drawcurs	; Make available
				; the startup2 and set_b2 files are gonna be used in this part
				
drawcurs 	PROC
	
			PUSH 	{R0,R1,R2, LR}
			
			LDR		R0, =Data
			MOV		R1, #499
			MOV		R2, #0x00
			
Loop		STRB	R2, [R0],#1
			SUB		R1, #1
			CMP		R1, #0
			BNE		Loop
			
			MOV		R2, #0x04
			STRB	R2, [R0], #1
					
			MOV		R2, #0x04
			STRB	R2, [R0], #1
			
			MOV		R2, #0x1F
			STRB	R2, [R0], #1
			
			MOV		R2, #0x04
			STRB	R2, [R0], #1
			
			MOV		R2, #0x04
			STRB	R2, [R0], #1
			
			MOV		R1, #499
			MOV		R2, #0x00
			
Loop1		STRB	R2, [R0],#1
			SUB		R1, #1
			CMP		R1, #0
			BNE		Loop1
			
			POP {R0,R1,R2,LR}
			BX		LR
			ENDP
			