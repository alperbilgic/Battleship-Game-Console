NVIC_ST_CTRL  		EQU		0xE000E010
GPIO_PORTB_DATA		EQU 	0x400053FC

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		drawcurs
			EXPORT  	SysTick_Handler	; Make available
			
				
			
SysTick_Handler	PROC	
 		PUSH			{R1,R0,LR}
		
		SUB			R10, #1
		CMP			R10, #0
		BNE			ENDD
		LDR R0, =NVIC_ST_CTRL ; SYSTICK control and status register
		MOV R1, #0
		STR R1, [R0] ; stop counter to prevent interrupt triggered accidentally
		

ENDD	BL	drawcurs

		POP			{R0,R1,LR}
		BX 			LR
		ENDP