.data

.text
# SBAGLIATO (primo tentativo)
	li $f0, 6
	syscall
	
	ldc1 $f4, $f0
	
	li $v0, 2
	move.s $f12, $f4 
	syscall