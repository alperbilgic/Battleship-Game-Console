NVIC_ST_CTRL  		EQU		0xE000E010
GPIO_PORTB_DATA		EQU 	0x400053FC

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		timetable
			EXPORT  	SysTick_Handler	; Make available
			
				
			
SysTick_Handler	PROC	
 		PUSH			{R0-R12,LR}
		
		LDR	R0, =0x20000008
		LDR	R10, [R0]
		SUB	R10, #1
		STR	R10, [R0]
		CMP R10, #0
		BNE	ENDD
		LDR R0, =NVIC_ST_CTRL ; SYSTICK control and status register
		MOV R1, #0
		STR R1, [R0] ; stop counter to prevent interrupt triggered accidentally
		

ENDD	BL	timetable

		POP			{R0-R12, LR}
		BX 			LR
		ENDP