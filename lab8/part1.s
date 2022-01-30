.text
.global ONES	

ONES:
	MOV R0,#0
	LOOP:
		CMP R1,#0
		BEQ ENDSUB
		LSR R2,R1,#1
		AND R1,R1,R2
		ADD R0,#1
		B LOOP
	ENDSUB:
		MOV PC,LR