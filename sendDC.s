SSISR		EQU		0x4000800C
SSIDR		EQU		0x40008008

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXPORT		sendDC
				
			
			
sendDC		PROC
	
			PUSH		{R1,R0}   ; R2 WILL BE PASSED
	
			
			LDR			R0, =SSISR
LUP			LDR			R1, [R0]
			AND			R1, #0x10
			CMP			R1, #0x10
			BEQ			LUP				; wait until tx buffer is ready
			
			LDR			R0, =SSIDR
			STR			R2, [R0]
			
			LDR			R0, =SSISR
LUP1		LDR			R1, [R0]
			AND			R1, #0x10
			CMP			R1, #0x10
			BEQ			LUP1				; wait until tx buffer is ready			
			
			
			POP			{R1,R0}
			BX			LR
			ENDP
			

			