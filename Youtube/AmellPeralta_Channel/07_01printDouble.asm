.data
	first:   	.double 7.202
	second: 	.double 3.67
	
	risultato: 	.double 0.0

.text
.globl main

main:
	la $t0, first 	#leggo indirizzo double nella ram
	ldc1 $f4, 0($t0) # tutti gli $f tranne dispari e 0, 2,12,14... 0 e 2 sono come return $v e 12,14 come arguments $a
	
	la $t0, second 	#leggo indirizzo double nella ram
	ldc1 $f6, 0($t0) # tutti gli $f tranne dispari e 0, 2,12,14... 0 e 2 sono come return $v e 12,14 come arguments $a
	
	add.d $f8, $f4, $f6  #sommiamo f4 e f6 che sono praticamente valori tradotti da indirizzo ram a messi in cpu coproc1 gia in double
	
	la $t0, risultato # indirizzo ram risultato
	sdc1 $f8, 0($t0) # scrivo il risultato nella ram
	
	li $v0, 3 # write double code
	# ldc1 $f12, 0($t0) # lenta # uso indirizzo di risultato che ho già riempito con store
	mov.d $f12, $f8 # ho gia il valore, perchè dovrei leggerlo dalla ram?
	syscall
	
	j exit
	
exit:
	li $v0, 10
	syscall
