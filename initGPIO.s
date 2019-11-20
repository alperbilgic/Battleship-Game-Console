GPIO_PORTA_DATA		EQU 	0x400043FC ; data address
GPIO_PORTA_DIR		EQU 	0x40004400
GPIO_PORTA_AFSEL 	EQU 	0x40004420
GPIO_PORTA_DEN 		EQU 	0x4000451C
GPIO_PORTA_PCTL		EQU		0x4000452C
SYSCTL_RCGCGPIO 	EQU 	0x400FE608
PCTL_NUMBER			EQU		0x00202200


;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB

			EXPORT  	initGPIO	; Make available
				
initGPIO	PROC
	
			PUSH 		{R1,R0,R4,R2}
			
			LDR			R0,=SYSCTL_RCGCGPIO
			LDR			R1,[R0]
			ORR			R1,#0x01			; PORT A CAN BE SET FROM THE SECOND BIT
			STR			R1,[R0]				; THE CLOCK OF PORT A IS SET
			NOP
			NOP
			NOP
			
			LDR 		R1,=GPIO_PORTA_DEN		; THIS SHOULD BE ENABLED TO LET THE DIGITAL I/O
			LDR 		R0,[ R1 ]
			ORR 		R0,#0xEC				; RX and PA0 pins are desabled
			STR 		R0,[ R1 ] 				; CONFIGURATION OF PORT A ENDS
			
			LDR			R0,=GPIO_PORTA_DIR
			LDR			R1,[R0]
			AND			R1,R1,#0x00			; CLEAR R1
			ORR			R1,R1,#0xC0			; THE 1'S ARE OUT
			STR			R1,[R0]
			
			LDR			R0,=GPIO_PORTA_DATA
			LDR			R1,[R0]
			ORR			R1,R1,#0x80			; RESET = 1
			STR			R1,[R0]
			
			LDR 		R1,=GPIO_PORTA_AFSEL		; 
			LDR 		R0,[ R1 ]
			BIC 		R0,#0xFF
			ORR 		R0, #0x2C					; CONFIGURE CLK, CE AND TX PINS
			STR 		R0,[ R1 ]
			
			LDR 		R1,=GPIO_PORTA_PCTL			;
			LDR			R0, [R1]
			LDR			R2,=PCTL_NUMBER
			ORR			R0,R2				; PCTL SSI0 CONFIGURATION FOR PINS 2,3 AND 5
			STR			R0, [R1]
			
			
			POP			{R1,R0,R4,R2}
			
			BX 			LR
			ENDP