.data
	message: 		.asciiz "Enter the value of PI: "
	zeroAsFloat: 	.float 0.0
.text
.globl main

main:
	lwc1 $f4, zeroAsFloat
	jal printMessage
	jal readFloat
	jal printFloat
	
readFloat:
	li $v0, 6
	syscall
	jr $ra
	
printFloat:
	li $v0, 2
	# move.s $f12, $f0 # NON COMPILA ERRORE, SALVO ERRORE PRIMA DI ALTRE MODIFICHE
	jr $ra
			
printMessage:
	li $v0, 4
	la $a0, message
	syscall
	jr $ra
	
finishProgram:
	li $v0, 10
	syscall