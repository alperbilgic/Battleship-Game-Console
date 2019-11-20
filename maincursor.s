GPIO_PORTA_DATA		EQU 	0x400043FC
SSIDR				EQU		0x40008008
SSISR				EQU		0x4000800C
DATA				EQU		0x20000800
DATA2				EQU		0x20000F00
DATAZERO			EQU     0x20001000

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		initSSI
			EXTERN		initGPIO
			EXTERN		delayy
			EXTERN		sendDC
			EXTERN		fillzero
			EXTERN		drawcurs
			EXTERN		get_rc
			EXTERN		gpio_f
			EXTERN		screenzero
			EXTERN		screen
			EXTERN		newscreenzero
			EXTERN		screen2
			EXTERN		mines
			EXTERN		InitSysTick
			EXTERN		screen3

				
			EXPORT  	__main	; Make available
				; the startup2 and set_b2 files are gonna be used in this part
				
__main		CPSIE		I
			BL			initGPIO		; PORT B IS INITIALIZED
			BL			initSSI
			BL			screenzero
			
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
			BL			gpio_f
			MOV			R11, #0
			LDR			R0, =0x20000004
			STR			R11, [R0]
			LDR			R0, =0x2000000C
			STR			R11, [R0]
			
return		LDR			R0, =0x20000004
			LDR			R11, [R0]		; R11 holds the value how many times the button is pressed
			CMP			R11, #4
			BHI			ileri
			BL			get_rc			; if the value is less then 4 battleship cursor is placed on memory
			BL			screen			; the screen matrix is gotten by gathering cursor and ships memories
			LDR			R5, =DATA
			B			ipileri
ileri		CMP			R11, #5			; if button is pressed for 5 times give blank screen
			BHI			ileri2
			BL			newscreenzero
			LDR			R5, =DATAZERO
			B			ipileri
ileri2		CMP			R11, #6			; if button is pressed for 6 times give ships on the screen
			BHI			ileri3			; the delay is given after the screen data is sent to NOKIA
			BL			screen3			; the battle and civilian ships gathered into a space in memory
			LDR			R5,=DATA		; the data is gotten from memory place where ships are placed
			B			ipileri

ileri3		BL			mines			; if buttons are pressed more then 6 times go to P2 screen
			BL			screen2			; gather cursor mem.  and mines mem.
			LDR			R5, =DATA2		; the data place to send as screen is changed to gathered memory space
			
				
ipileri		MOV			R6, R5			; screen data place is loaded to R6
			MOV			R4, #63			; 64 words are to be sent for screen printing
			MOV			R3, #1			; the data is sent byte by byte so R3 will hold how many times a 64 byte package is sent
			
			LDR			R0, =GPIO_PORTA_DATA		; send command
			LDR			R1, [R0]
			BIC			R1, #0x40
			STR			R1, [R0]
			
			MOV			R2, #0x41		; Y POSITION
			BL			sendDC
			
			MOV			R2, #0x88		; X POSITION
			BL			sendDC
			
			
			LDR			R0, =GPIO_PORTA_DATA
			LDR			R1, [R0]
			ORR			R1, #0x40
			STR			R1, [R0]

lp			LDRB		R2, [R5],#4
			BL			sendDC
			SUB			R4, #1
			CMP			R4, #0
			BNE			lp
			ADD			R3, #1		; one pack of 64 byte is sent
			
			LDR			R0, =GPIO_PORTA_DATA		; send command
			LDR			R1, [R0]
			BIC			R1, #0x40
			STR			R1, [R0]
			
			ORR			R2, R3, #0x40
					; Y POSITION
			BL			sendDC
			
			MOV			R2, #0x88		; X POSITION
			BL			sendDC
			
			LDR			R0, =GPIO_PORTA_DATA
			LDR			R1, [R0]
			ORR			R1, #0x40
			STR			R1, [R0]
			
			ADD			R6, #1
			MOV			R5, R6
			MOV			R4, #63
			CMP			R3, #5
			BNE 		lp
			;BL			delayy
			CMP			R11, #6
			BNE			endd
			BL			delayy			; if the buttons are pressed for 6 times there should be a delay for 0.5 sec
			BL			delayy
			BL			delayy
			BL			delayy
			BL			delayy
			CMP			R11, #6
			LDR			R0, =0x20000004
			LDR			R11, [R0]
			ADD			R11, #1
			STR			R11, [R0]
			LDR			R0, =0x20000008
			MOV			R10, #21
			STR			R10, [R0]
			BL			InitSysTick		; after 0.5 sec duration of battle field display the counter is started
			
			
			
endd		LDR			R0, =0x20000004	; if the buttons are pressed for five times zero screen should be sent
			LDR			R11, [R0]
			CMP			R11, #5
			BNE			zip
LoopZ		LDR			R0, =0x20000004
			LDR			R11, [R0]
			CMP			R11, #5
			BNE			zip
			BL			fillzero		; screen is cleared until next press of any button
			B			LoopZ

zip			B			return

			ALIGN
			END