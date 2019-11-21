DATA		EQU  		0x20000000

;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB
			EXTERN		gpio_f

			EXPORT  	__main	; Make available
				; the startup2 and set_b2 files are gonna be used in this part
				
__main		
			CPSIE		I			; INTERRUPTS ENABLED
			
			BL			gpio_f		; PORT B IS INITIALIZED
inf			WFI			
			B			inf
			ALIGN
			END