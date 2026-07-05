.data

.text
.globl main

main:
	# multiplicazione			divisione
	# mul						div				
	# multu						divu			(unsigned, quindi valore grande senza segno tipo 4,2*10^9 al posto di 2.1*10^9
	# sll						srl				(shift left/right logical). left è *2^n mentre right è /2^n
	
exit:
	li $v0, 10
	syscall