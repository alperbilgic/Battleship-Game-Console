GPIO_PORTF_DATA		EQU 	0x400253FC
GPIO_PORTF_DEN 		EQU 	0x4002551C
GPIO_PORTF_PUR		EQU		0x40025510
GPIO_PORTF_ICR		EQU		0x4002541C
GPIO_PORTF_RIS		EQU		0x40025414
IOB 				EQU 	0x0F
SYSCTL_RCGCGPIO 	EQU 	0x400FE608
NVIC_ST_RELOAD 		EQU 	0xE000E014


;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		delayy
			EXTERN		get_row_col
			EXTERN		battleship
			EXTERN		civilian
			EXTERN		screen
			EXPORT  	buttons	; Make available,
			
				
			
buttons		PROC
			PUSH		{R0,R1,R8,R6,LR}
			
			
			
			LDR			R0,=GPIO_PORTF_RIS
			LDR			R1, [R0]
			BIC			R1, #0xEE
			
			CMP			R1, #0x10
			BNE 		ZIP
			BL			battleship	; if button 1 is pressed place a battleship
			B			ileri
ZIP			BL			civilian	; if button 2 is pressed place a civilian ship
			
ileri		
			
			

			POP			{R0,R1,R8,R6,LR}
			BX			LR
			ENDP