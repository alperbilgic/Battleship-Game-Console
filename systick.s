;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; Your SystemTimer . s s o u r c e f i l e t o implement
; i n i t i a l i z a t i o n and ISR
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; D e f i n i t i o n o f the l a b e s s t a n di n g f o r
; the a d d r e s s o f the r e g i s t e r s
NVIC_ST_CTRL 		EQU 	0xE000E010
NVIC_ST_RELOAD 		EQU 	0xE000E014
NVIC_ST_CURRENT	 	EQU 	0xE000E018
SHP_SYSPRI3 		EQU 	0xE000ED20
; end o f the r e g i s t e r l a b e l d e f i n i t i o n s
; 0x7D0 = 2000 -> 2000*250 ns = 500mus
RELOAD_VALUE 		EQU 	0x00010000
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; I n i t i a l i z a t i o n a r e a
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;LABEL 		DIRECTIVE 		VALUE 		COMMENT
			AREA 			initisr , CODE, READONLY, ALIGN=2
			THUMB
			EXPORT 			InitSysTick
InitSysTick PROC
			PUSH	{R1,R0,R2,LR}	
		
			LDR R0, =NVIC_ST_CTRL ; SYSTICK control and status register
			MOV R1, #0
			STR R1, [R0] ; stop counter to prevent interrupt triggered accidentally
			LDR R1, =0x003D0900 ; trigger every 100000 cycles
			STR R1, [R0,#4] ; write reload value to reload value register
			MOV	R2, #1		; first reload is 1 since getting into the systick as short as possible to print value of '20'
			STR R2, [R0,#8] ; write any value to current value
			MOV R1, #0x3 ; enable interrupt, enable SYSTICK counter
			STR R1, [R0] ; start counter
			
			POP	{R1,R0,R2,LR}
			BX LR
