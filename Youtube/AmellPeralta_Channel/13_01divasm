.data

.text
.globl main

main:
	li $t0, 30
	li $t1, 5
	
	# div $s0, $t0, $t1 # guarda sotto, puoi anche fare divisione direttamente con i valori costanti immediate
	div $s0, $t0, 10
	
	
	# f0 e f2 return
	# f12 e f14 arguments
	li $v0, 1
	move $a0, $s0
	
	syscall
	