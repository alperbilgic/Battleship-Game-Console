;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	subroutin, READONLY, CODE
			THUMB

			EXPORT  	delayy	; Make available
				
delayy		PROC
			PUSH		{R1,LR}
			LDR			R1,=525000	; count from 525000 to 0
Loop		SUBS		R1,#1
			BNE			Loop
			POP			{R1,LR}
			
			BX			LR

			ENDP