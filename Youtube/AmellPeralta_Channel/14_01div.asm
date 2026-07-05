.data

.text
.globl main

main:
	li $t0, 30
	li $t1, 8
	
	# div $s0, $t0, $t1 # guarda sotto, puoi anche fare divisione direttamente con i valori costanti immediate
	div $t0, $t1
	mflo $s0 # quotient
	mfhi $s1 # resto
	
	li $v0, 1
	move $a0, $s0
	
	syscall
	