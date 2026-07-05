.data
	message: 		.asciiz "Enter the value of PI: "
	# zeroAsFloat: 	.float 0.0
.text
.globl main

main:
	# la $t0, zeroAsFloat
	# lwc1 $f4, 0($t0)
	jal printMessage
	jal readFloat
	jal printFloat
	j finishProgram
	
readFloat:
	li $v0, 6
	syscall
	jr $ra
	
printFloat:
	li $v0, 2
	mov.s $f12, $f0
	syscall
	jr $ra
			
printMessage:
	li $v0, 4
	la $a0, message
	syscall
	jr $ra
	
finishProgram:
	li $v0, 10
	syscall