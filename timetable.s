GPIO_PORTA_DATA		EQU 	0x400043FC
SSIDR				EQU		0x40008008
SSISR				EQU		0x4000800C
NVIC_ST_CTRL 		EQU 	0xE000E010
NVIC_ST_RELOAD 		EQU 	0xE000E014
NVIC_ST_CURRENT	 	EQU 	0xE000E018
SHP_SYSPRI3 		EQU 	0xE000ED20

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		sendDC
			EXTERN		decision
				
			EXPORT  	timetable	; Make available
				; the startup2 and set_b2 files are gonna be used in this part
				
timetable	PROC		; THIS PART OF THE CODE RESETS THE WHOLE DATA IN NOKIA LCD
	
			PUSH		{R0-R12, LR}
			
			LDR			R0, =GPIO_PORTA_DATA
			LTORG
			
			LDR			R1, [R0]
			BIC			R1, #0x40		; COMMAND MODE
			STR			R1, [R0]
			
	
			MOV			R2, #0x40		; Y POSITION
			BL			sendDC
			
			MOV			R2, #0xCC		; X POSITION
			BL			sendDC
			
			
			
			LDR			R0, =GPIO_PORTA_DATA
			LTORG
			LDR			R1, [R0]
			ORR			R1, #0x40
			STR			R1, [R0]
			
			LDR			R0, =SSIDR
			LTORG
			
			CMP			R10, #20		; the numbers will be sent considering the value of R10 which has the instant value 
										;of seconds
			BNE			ondokuz
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
			
ondokuz		CMP			R10, #19
			BNE			onsekiz
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x46
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			
			
onsekiz		CMP			R10, #18
			BNE			onyedi
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x76
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x76
			BL			sendDC
			
onyedi		CMP			R10, #17
			BNE			onalti
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x03
			BL			sendDC
			MOV			R2, #0xF1
			BL			sendDC
			MOV			R2, #0x09
			BL			sendDC
			MOV			R2, #0x07
			BL			sendDC			

onalti		CMP			R10, #16
			BNE			onbes
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x72
			BL			sendDC

onbes		CMP			R10, #15
			BNE			ondort
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x4F
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x71
			BL			sendDC


ondort		CMP			R10, #14
			BNE			onuc
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x18
			BL			sendDC
			MOV			R2, #0x14
			BL			sendDC
			MOV			R2, #0x12
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			
			
onuc		CMP			R10, #13
			BNE			oniki
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x42
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x76
			BL			sendDC	

oniki		CMP			R10, #12
			BNE			onbir
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0xC2
			BL			sendDC
			MOV			R2, #0xA1
			BL			sendDC
			MOV			R2, #0x99
			BL			sendDC
			MOV			R2, #0x86
			BL			sendDC
			
onbir		CMP			R10, #11
			BNE			onn
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			
			
onn			CMP			R10, #10
			BNE			dokuz
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC

dokuz		CMP			R10, #9
			BNE			sekiz
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x46
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC


sekiz		CMP			R10, #8
			BNE			yedi
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x76
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x76
			BL			sendDC
			
			
yedi		CMP			R10, #7
			BNE			alti
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x03
			BL			sendDC
			MOV			R2, #0xF1
			BL			sendDC
			MOV			R2, #0x09
			BL			sendDC
			MOV			R2, #0x07
			BL			sendDC
			
			
alti		CMP			R10, #6
			BNE			bes
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x72
			BL			sendDC
			
			
bes			CMP			R10, #5
			BNE			dort
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x4F
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x71
			BL			sendDC
			
			
dort		CMP			R10, #4
			BNE			uc
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x18
			BL			sendDC
			MOV			R2, #0x14
			BL			sendDC
			MOV			R2, #0x12
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			
			
			
uc			CMP			R10, #3
			BNE			iki
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x42
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x89
			BL			sendDC
			MOV			R2, #0x76
			BL			sendDC	


iki			CMP			R10, #2
			BNE			bir
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0xC2
			BL			sendDC
			MOV			R2, #0xA1
			BL			sendDC
			MOV			R2, #0x99
			BL			sendDC
			MOV			R2, #0x86
			BL			sendDC
			
			
bir			CMP			R10, #1
			BNE			sifir
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x00
			BL			sendDC
			MOV			R2, #0x02
			BL			sendDC
			MOV			R2, #0xFF
			BL			sendDC
			

sifir		CMP			R10, #0
			BNE			endd
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x81
			BL			sendDC
			MOV			R2, #0x7E
			BL			sendDC
			
			LDR R0, =NVIC_ST_CTRL ; SYSTICK control and status register
			MOV R1, #0
			STR R1, [R0] ; stop counter to prevent interrupt triggered accidentally
			
			BL			decision
			
			
endd		POP			{R0-R12, LR}
			BX 			LR
			
			ENDP