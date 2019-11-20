mines_address	EQU			0x20000E00



				AREA    	part1, CODE, READONLY
				THUMB
				EXTERN 		get_row_col_mine
				EXPORT  	buttons2	


buttons2		PROC
				PUSH {R0,R1,R2,R3,R4,R5,R6,R7,R8, LR}
				
				LDR R0, =0x2000000C
				LDR	R1, [R0]
				ADD	R1, #1
				STR	R1, [R0]
				; if player 2 is playing and button is pressed
get_rc			BL	get_row_col_mine	; get the values for rows and columns
check_row		CMP R2,R9; R9 is previous row
				BNE start
check_col		CMP R3, R10; R10 is previous column
				BEQ get_rc
start			
				LDR R4,= mines_address	; mines will be placed to space starting with this value
				MOV R5,#0
	
				
				MOV R9, R2	; 
				MOV R10,R3	; columns value is gotten and the desired column is gotten by passing the values till 
							; this value is gotten
				
st				CMP R5, R3
				BNE loop
				LDR R8, = 0xFF000000
shift			CMP R2,#0	; the row location is gotten by shifting the desired shape value
				BEQ continue
				LSR R8,#1
				SUB R2,#1
				B shift
continue		MOV R2, R9
				LDR R6, [R4]
				ORR	R8, R6
				STR R8, [R4], #4
				LDR R6, [R4,#12]
				ORR	R8, R6
				STR R8, [R4,#12]
				LDR R8,=0x99000000
shift2			CMP R2,#0
				BEQ go 
				LSR R8,#1
				SUB R2,#1
				B shift2
go				LDR R6, [R4]		; the desired shape is given but ORR'ed not to lose the past mines
				ORR	R8, R6
				STR R8, [R4],#4
				LDR R6, [R4]
				ORR	R8, R6
				STR R8, [R4],#4
				LDR R6, [R4]
				ORR	R8, R6
				STR R8, [R4],#4
				LDR R6, [R4]
				ORR	R8, R6
				STR R8, [R4],#4
				LDR R6, [R4]
				ORR	R8, R6
				STR R8, [R4],#4
				LDR R6, [R4]
				ORR	R8, R6
				STR R8, [R4],#8
				ADD R5, #8
loop			CMP R5, #65
				BEQ endd
				LDR R8,= 0x00000000
				LDR R6, [R4]
				ORR	R8, R6
				STR R8, [R4], #4
				ADD R5, #1			
				B	st
endd
				POP {R0,R1,R2,R3,R4,R5,R6,R7,R8, LR}
				BX 	LR
				END 