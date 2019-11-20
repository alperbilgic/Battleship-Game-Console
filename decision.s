mine			EQU			0x20000E00
civilian		EQU			0x20000700
battle_sayisi	EQU			0x20000000
battle_1		EQU			0x20000900


				AREA    	part1, CODE, READONLY
				THUMB
				EXTERN		P1_won
				EXTERN		P2_won
				EXPORT  	decision	
decision

start			PROC 

				PUSH {R0-R12,LR}
				MOV R9,#64
				LDR R0,= mine
				LDR R2, = civilian
				LDR R4,= battle_sayisi
				LDR R5, [R4]
				
civ				LDR R1, [R0], #4	; this part controls if a civilian ship got hit
				LDR R3, [R2], #4	; R1 is not 0 if there is a mine and R3 is non zero if there is a civilian
				AND R1, R3		; if AND value is different from '0' a civilian is hit
				CMP	R1, #0		
				BNE P1_won
				SUBS R9,#1
				BNE civ
									; below part controls if all battle ships are hit
									; that is why the code turns for number of battleship times
				LDR R0,= mine		; the address value of start of mine space
				LDR R2, = battle_1	; the address value of start point of the first battle ship
battle_n		MOV R9,#64			; since values are increased for 64 times the address of next battleship memory is gotten automatically
				MOV R10, #0			
battle			LDR R1, [R0], #4	; the battleship areas are and'ed with mines
				LDR R3, [R2], #4
				AND R1,R3
				CMP	R1, #0
				MOVNE R10,#1		; R10 is the flag which shows if the ship in the controlled area got hit
				SUBS R9,#1
				BNE battle
				
				CMP R10,#0			; if R10 is '0' after controlling all areas player 1 is the winner
				BEQ P1_won
				SUBS R5, #1
				BNE battle_n
				
				B P2_won	; if player 1 is not assigned as the winner than the second player is the winner
				
				POP {R0-R12,LR}
				END