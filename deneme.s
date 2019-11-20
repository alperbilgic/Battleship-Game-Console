				AREA    	part1, CODE, READONLY
				THUMB
				EXTERN 		get_row_col
				EXPORT  	get_rc	


				
get_rc			PROC
				PUSH {R0,R1,R2,R3,R4,R5,R6,R7,R8, LR}
getrow			BL	get_row_col			; get value from ADC
check_row		CMP R2,R9; R9 is previous row
				BNE start
check_col		CMP R3, R10; R10 is previous column
				BEQ getrow	; if values are same go back to get new values
start			MOV R10,R3	; R10 gets the next column
				LDR R4,=0x20000500
				MOV R5,#0
				;CMP R2, #2
				;BLT getrow
				;CMP R3, #2
				;BLT getrow
				;CMP R2, #29
				;BGT getrow
				;CMP R3, #61
				;BGT getrow
				SUB R6,R3,#2; column-2
				SUB R7, R2, #2; row-2
				
st				CMP R5, R6		; save screen page
				BNE loop
				LDR R8, = 0x00000001	; to create the horizontal line of the cursor
shift			CMP R2,#0
				BEQ continue
				LSL R8,#1
				SUB R2,#1
				B shift
continue		ADD	R9, R7, #2
				STR R8, [R4], #4
				STR R8, [R4], #4
				STR R8, [R4,#4]
				STR R8, [R4,#8]
				LDR R8,=0x0000001F	; to create the vertical line of the cursor
shift2			CMP R7,#0
				BEQ go 
				LSL R8,#1
				SUB R7,#1
				B shift2
go				STR R8, [R4], #12
				ADD R5, #5
loop			CMP R5, #65
				BHS endd
				LDR R8,= 0x00000000	; the places different from cursor are loa
				STR R8, [R4], #4
				ADD R5, #1			
				B	st
endd
				POP {R0,R1,R2,R3,R4,R5,R6,R7,R8, LR}
				BX  LR
				END 