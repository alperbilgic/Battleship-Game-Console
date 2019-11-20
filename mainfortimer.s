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
			EXTERN		InitSysTick
				
			EXPORT  	__main	; Make available
				; the startup2 and set_b2 files are gonna be used in this part
				
__main		
			BL			initGPIO		; PORT B IS INITIALIZED
			BL			initSSI
			
			
			LDR			R0, =GPIO_PORTA_DATA
			LDR 		R1, [R0]
			BIC 		R1, #0x80
			STR			R1, [R0]
			BL			delayy
			
			ORR			R1, # 0x80
			STR			R1, [R0]
			
			LDR			R0, =SSISR
LUP			LDR			R1, [R0]
			AND			R1, #0x10
			CMP			R1, #1
			BEQ			LUP
			
			LDR			R1, =GPIO_PORTA_DATA
			LDR			R1, [R0]
			BIC			R1, #0x40		; D/C PIN IS CLEARED (COMMAND)
			STR			R1, [R0]
			
			LDR			R0, =SSIDR
			MOV			R1, #0x21
			STR			R1, [R0]
			
			MOV			R2, #0xA4		; VOP
			BL			sendDC
			
			MOV			R2, #0xB8		; CONTRAST
			BL			sendDC
			
			
			MOV			R2, #0x04		; TEMPERATURE
			BL			sendDC
			
			
			MOV			R2, #0x13		; BIAS MODE
			BL			sendDC
			
			
			MOV			R2, #0x20		; H=0
			BL			sendDC
			
			
			MOV			R2, #0x0C		; NORMAL DISPLAY
			BL			sendDC
			
			BL			fillzero
			
			MOV			R10, #20
			
			LDR			R0, =GPIO_PORTA_DATA
			
			LDR			R1, [R0]
			BIC			R1, #0x40		; COMMAND MODE
			STR			R1, [R0]
			
	
			MOV			R2, #0x40		; Y POSITION
			BL			sendDC
			
			MOV			R2, #0xCC		; X POSITION
			BL			sendDC
			
			LDR			R0, =GPIO_PORTA_DATA
			
			LDR			R1, [R0]
			ORR			R1, #0x40
			STR			R1, [R0]
			
			LDR			R0, =SSIDR
			
			MOV			R2, #0xC2
			BL			sendDC
			MOV			R2, #0xA1
			BL			sendDC
			MOV			R2, #0x99
			BL			sendDC
			MOV			R2, #0x86
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			
			BL			InitSysTick
			
			CPSIE		I
			
Loop		WFI				
			B			Loop

			ALIGN
			END