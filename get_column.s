	
					
RCGCADC 		EQU 		0x400FE638 ; ADC clock
ADC0_ACTSS 		EQU 		0x40038000 ; Sample seq (ADC0)
ADC0_RIS 		EQU 		0x40038004 ; Interrupt status
ADC0_IM 		EQU			0x40038008 ; Interrupt select
ADC0_EMUX 		EQU 		0x40038014 ; Trigger select
ADC0_PSSI 		EQU 		0x40038028 ; Initiate sample
ADC0_SSMUX3 	EQU 		0x40038080 ; Input channel select
ADC0_SSCTL3 	EQU 		0x40038084 ; Sample seq control
ADC0_SSFIFO3 	EQU 		0x40038088 ; Channel 3 read
ADC0_PC 		EQU 		0x40038FC4 ; Sample rate
ADC0_ISC		EQU			0x4003800C
	
RCGCGPIO 		EQU 		0x400FE608
PORTE_DEN 		EQU 		0x4002451C 
PORTE_PCTL 		EQU 		0x4002452C 
PORTE_AFSEL 	EQU 		0x40024420
PORTE_AMSEL 	EQU 		0x40024528 


				AREA    	part1, CODE, READONLY
				THUMB
							
				EXPORT  	get_row_col	

get_row_col

start			PROC

				PUSH {R0-R1,R4-R12,LR}
				LDR R1, =RCGCADC ;ADC clock on
				LDR R0, [R1]
				ORR R0, R0, #0x01 ;ADC0
				STR R0, [R1]
				NOP
				NOP
				NOP 

				LDR R1, =RCGCGPIO ;GPIO clock on
				LDR R0, [R1]
				ORR R0, R0, #0x10 ; port E 
				STR R0, [R1]
				NOP
				NOP
				NOP 

				LDR R1, =PORTE_AFSEL
				LDR R0, [R1]
				ORR R0, R0, #0x0C ;  alt on for PE2-3
				STR R0, [R1]
			
				
				LDR R1, =PORTE_DEN
				LDR R0, [R1]
				BIC R0, R0, #0x0C ; disable for PE2-3
				STR R0, [R1]
				
				LDR R1, =PORTE_AMSEL
				LDR R0, [R1]
				ORR R0, R0, #0x0C ; enable analog for PE2-3
				STR R0, [R1]

				LDR R1, =ADC0_ACTSS ; disable during setup
				LDR R0, [R1]
				BIC R0, R0, #0x04 
				STR R0, [R1]
				
				LDR R1, =ADC0_EMUX; trigger
				LDR R0, [R1]
				BIC R0, R0, #0xF00 ;SOFTWARE
				STR R0, [R1] 

				LDR R1, =ADC0_SSMUX3; input
				LDR R0, [R1]
				MOV R0, #0x10 ;  AIN0-1
				STRB R0, [R1]
				
				LDR R1, =ADC0_SSCTL3; sample seq
				LDR R0, [R1]
				ORR R0, R0, #0x060 ;(IE0, END0)
				STR R0, [R1]
				
				LDR R1, =ADC0_PC; sample rate
				LDR R0, [R1]
				ORR R0, R0, #0x01 ; set bits 3:0 to 1 for 125k sps
				STR R0, [R1]
				
				LDR R1, =ADC0_ACTSS
				LDR R0, [R1]
				ORR R0, R0, #0x04 ; enable seq 2
				STR R0, [R1] 
				
				LDR R3, =ADC0_RIS ; interrupt address
				LDR R4, =ADC0_SSFIFO3 ; read 
				LDR R2, =ADC0_PSSI ; sample sequence initiate address
				LDR R6,= ADC0_ISC; interrupt clear
				MOV R7, #0
				
Smpl 			LDR R0, [R2]
				ORR R0, R0, #0x04 ; set bit 3 for SS3
				STR R0, [R2]; sampling is initiated
				
Cont 			LDR R0, [R3]; check if interrupt happened
				ANDS R0, R0, #4
				BEQ Cont
				MOV R0, #0x4
				STR R0, [R6]
				
				LDR R0,[R4]
				MOV R1, #0x44
				MOV R3, #0
compare			CMP R0,R1
				BLT exit
				ADD R3,#1
				ADD R1,#0x44
				B compare				
exit			;R3 is the column number between 0-61
				
				LDR R0,[R4]
				MOV R1, #0x92
				MOV R2, #0
compare2		CMP R0,R1
				BLT exit2
				ADD R2,#1
				ADD R1,#0x92
				B compare2				
exit2			;R2 is the row number between 0-29
				
				POP {R0-R1,R4-R12,LR}
				BX		LR
				ENDP
				END
									
									