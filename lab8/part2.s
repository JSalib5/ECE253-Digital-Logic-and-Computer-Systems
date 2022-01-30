.global _start
_start:
	LDR 	R4, =LIST
	LDR		R5, [R4]
	ADD		R4, R4, #4
	MOV		R6, #0

ILOOP:
	CMP 	R6, R5
	BGE		END

	MOV R7, #0
	MOV R9, R4
JLOOP:
	SUB		R8, R5, R6
	SUB		R8, R8, #1
	CMP		R7, R8
	BGE		CNTILOOP

	MOV		R0, R9

	// ryan is mean :( not anymore
	BL		SWAP

CNTJLOOP:
	ADD R7, R7, #1
	ADD R9, R9, #4
	B JLOOP

CNTILOOP:
	ADD R6, R6, #1
	B ILOOP

.global SWAP
SWAP:
	LDR 	R1, [R0]
	LDR 	R2, [R0, #4]

	CMP 	R1, R2
	BLT 	NOSWAP

	STR 	R2, [R0]
	STR 	R1, [R0, #4]
	MOV 	R0, #1
	
ENDSWAP:
	MOV 	PC, LR

NOSWAP:
	MOV 	R0, #0
	B 		ENDSWAP

END: B END

