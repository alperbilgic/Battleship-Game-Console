GPIO_PORTA_DATA		EQU 	0x400043FC
SSIDR				EQU		0x40008008
SSISR				EQU		0x4000800C

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		initSSI
			EXTERN		initGPIO
			EXTERN		delayy
			EXTERN		sendDC
				
			EXPORT  	fillzero	; Make available
				; the startup2 and set_b2 files are gonna be used in this part
				
fillzero	PROC		; THIS PART OF THE CODE RESETS THE WHOLE DATA IN NOKIA LCD
	
			PUSH		{R0, R1, R2, LR}
	
			MOV			R2, #0x40		; Y POSITION
			BL			sendDC
			
			MOV			R2, #0x80		; X POSITION
			BL			sendDC
			
			
			LDR			R0, =GPIO_PORTA_DATA
			LDR			R1, [R0]
			ORR			R1, #0x40
			STR			R1, [R0]
			
			
return1		LDR			R1, [R0]
			BIC			R1, #0xBF
			CMP			R1, #0x40
			BNE			return1
			
			MOV			R1, #504
			MOV			R2, #0x00
			
fill		BL			sendDC			; send 00 byte to NOKIA for 504 times to have a blank page
			SUBS		R1, #1
			BNE			fill
			
			LDR			R0, =GPIO_PORTA_DATA
			LDR			R1, [R0]
			BIC			R1, #0x40			; D/C TO COMMAND MODE
			STR			R1, [R0]
			
return		LDR			R1, [R0]
			BIC			R1, #0xBF
			CMP			R1, #0x00
			BNE			return
			
			POP			{R0,R1,R2, LR}
			BX 			LR
			
			ENDP