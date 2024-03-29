GPIO_PORTF_DATA		EQU 	0x400253FC ; data address
GPIO_PORTF_DIR		EQU 	0x40025400
GPIO_PORTF_AFSEL 	EQU 	0x40025420
GPIO_PORTF_DEN 		EQU 	0x4002551C
GPIO_PORTF_PUR		EQU		0x40025510
GPIO_PORTF_LOCK		EQU		0x40025520
GPIO_PORTF_CR		EQU		0x40025524
IOB 				EQU 	0x0F
SYSCTL_RCGCGPIO 	EQU 	0x400FE608
GPIO_PORTF_IEV		EQU 	0x4002540C
GPIO_PORTF_IS		EQU 	0x40025404
GPIO_PORTF_IBE		EQU 	0x40025408
GPIO_PORTF_IM		EQU 	0x40025410
GPIO_PORTF_ICR		EQU 	0x4002541C
	
NVIC_EN0			EQU 		0xE000E100 						; IRQ 0 to 31 Set Enable Register
INT30				EQU 		0x40000000 						; Interrupt 30 enable - PORTF



;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB

			EXPORT  	gpio_f	; Make available
				
gpio_f		PROC
	
			PUSH 		{R1,R0,R4}
			
			LDR			R0,=SYSCTL_RCGCGPIO
			LDR			R1,[R0]
			ORR			R1,#0x20			; PORT F CAN BE SET FROM THE SECOND BIT
			STR			R1,[R0]				; THE CLOCK OF PORT B IS SET
			NOP
			NOP
			NOP
			
			LDR 		R1, =GPIO_PORTF_LOCK
			LDR			R0, =0x4C4F434B
			STR 		R0, [R1]
			LDR 		R1, =GPIO_PORTF_CR
			MOV 		R0, #0x11 			; committed Port F[4] & F[0]
			STR 		R0, [R1]
			
			LDR			R0,=GPIO_PORTF_DIR
			LDR			R1,[R0]
			AND			R1,R1,#0x00			; CLEAR R1
			ORR			R1,R1,#0x04			; THE 1'S ARE OUT
			STR			R1,[R0]
			
			LDR			R0,=GPIO_PORTF_PUR		; THE PULL UP REGISTORS OF INPUT BITS ARE SET
			LDR			R1,[R0]
			AND			R1,#0x00
			ORR			R1,#0x11
			STR			R1,[R0]

			LDR 		R1,=GPIO_PORTF_AFSEL		; DISABLE AFSEL
			LDR 		R0,[ R1 ]
			BIC 		R0,#0xFF
			STR 		R0,[ R1 ]
			
			LDR 		R1,=GPIO_PORTF_DEN		; THIS SHOULD BE ENABLED TO LET THE DIGITAL I/O
			LDR 		R0,[ R1 ]
			ORR 		R0,#0xFF
			STR 		R0,[ R1 ] 				; CONFIGURATION OF PORT B ENDS
			
			MOV			R0,#0
			LDR			R1,=GPIO_PORTF_IS
			STR			R0,[R1]   				; PORT IS EDGE SENSITIVE
			LDR			R1,=GPIO_PORTF_IBE		; NOT BOTH EDGES
			MOV			R0,#0x11
			
			LDR			R1,=GPIO_PORTF_IEV
			STR			R0,[R1]				; PORTB INPUT SIDE IS SET TO RISING EDGE
			LDR			R1,=GPIO_PORTF_IM
			STR			R0,[R1]				; THE INTERRUPTS ARE MASKED
			
			LDR			R1,=GPIO_PORTF_ICR
			STR			R0, [R1]				; CLEAR FLAGS
			
			
			LDR 		R1, =NVIC_EN0		; interrupt is enabled
			LDR			R2, =INT30
			STR 		R2, [R1]
			
			POP			{R1,R0,R4}
			
			BX 			LR
			ENDP