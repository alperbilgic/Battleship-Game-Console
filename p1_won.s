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
			EXTERN		fillzero
				
			EXPORT  	P1_won	; Make available
				; the startup2 and set_b2 files are gonna be used in this part
				
P1_won		
			BL			initGPIO		; PORT B IS INITIALIZED
			BL			initSSI
			
			
			LDR			R0, =GPIO_PORTA_DATA	;; SENDING COMMAND
			LDR			R1, [R0]
			BIC			R1, #0x40
			STR			R1, [R0]
			
			BL			fillzero			; the screen is cleared
			
			MOV			R2, #0x40		; Y POSITION
			BL			sendDC
			
			MOV			R2, #0x80		; X POSITION
			BL			sendDC
			
			
			LDR			R0, =GPIO_PORTA_DATA	;; SENDING DATA
			LDR			R1, [R0]
			ORR			R1, #0x40
			STR			R1, [R0]
			
return1		LDR			R1, [R0]
			BIC			R1, #0xBF
			CMP			R1, #0x40
			BNE			return1
			
			
			MOV			R2, #0xFF		; 'P1WON' word is showed on the screen
			BL			sendDC			; The datas of characters are sent by the code below
			
			MOV			R2, #0x11
			BL			sendDC
			
			MOV			R2, #0x11
			BL			sendDC
			
			MOV			R2, #0x1F
			BL			sendDC
			
			MOV			R2, #0x00
			BL			sendDC
			
			MOV			R2, #0xFF
			BL			sendDC
			
			MOV			R2, #0x00
			BL			sendDC
			
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x80
			BL			sendDC
			MOV			R2, #0x80
			BL			sendDC
			
			MOV			R2, #0xFF
			BL			sendDC
			
			MOV			R2, #0x80
			BL			sendDC
			MOV			R2, #0x80
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			
			
			MOV			R2, #0x81
			BL			sendDC
			
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			
			MOV			R2, #0xFF
			BL			sendDC
			
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0x08
			BL			sendDC
			MOV			R2, #0x20
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0xAF
			BL			sendDC
			
			
			
			
Loop		B 			Loop	; after winner is assigned the processor enters an infinite loop where the screen has the
								; announcement of the winner



			ALIGN
			END