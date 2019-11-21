mines_address	EQU			0x20000D00



				AREA    	part1, CODE, READONLY
				THUMB
				EXTERN 		get_row_col_mine
				EXPORT  	mines	


mines			PROC
				PUSH {R0,R1,R2,R3,R4,R5,R6,R7,R8, LR}
get_rc			BL	get_row_col_mine
check_row		CMP R2,R9; R9 is previous row
				BNE start
check_col		CMP R3, R10; R10 is previous column
				BEQ get_rc
start			
				LDR R4,= mines_address
				MOV R5,#0
	
				;SUB R6,R3,#2; column-2
				;SUB R7, R2, #2; row-2
				MOV R9, R2
				MOV R10,R3	; the row and column values are gotten
				
st				CMP R5, R3
				BNE loop
				LDR R8, = 0xFF000000
shift			CMP R2,#0		; row place is gotten by shifting the desired shape value for value of the row times
				BEQ continue
				LSR R8,#1
				SUB R2,#1
				B shift
continue		MOV R2, R9	; the desired shape is gotten from here
				STR R8, [R4], #4
				STR R8, [R4,#12]
				LDR R8,=0x99000000
shift2			CMP R2,#0
				BEQ go 
				LSR R8,#1
				SUB R2,#1
				B shift2
go				STR R8, [R4],#4
				STR R8, [R4],#4
				STR R8, [R4],#4
				STR R8, [R4],#4
				STR R8, [R4],#4
				STR R8, [R4],#8
				ADD R5, #8
loop			CMP R5, #65	; zeros are placed for other places
				BEQ endd
				LDR R8,= 0x00000000
				STR R8, [R4], #4
				ADD R5, #1			
				B	st
endd
				POP {R0,R1,R2,R3,R4,R5,R6,R7,R8, LR}
				BX 	LR
				END 