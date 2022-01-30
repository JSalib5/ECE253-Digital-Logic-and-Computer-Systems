.global _start
_start:
		LDR R5,=0
		LDR R7,=0
		LDR R8,=0
		LDR R9,=0
		LDR R4,=TEST_NUM

LOOP: 	LDR R5,[R4,R9]
		CMP R5,#-1
		BEQ END
		ADD R7,R5,R7
		ADD R8,#1
		ADD R9,#4
		B	LOOP	
	
END: B END

.end
	