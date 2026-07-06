.data
	promptMessage: 	.asciiz "enter a number to find its factorial: "
	resultMessage: 	.asciiz "\nThe factorial of the number is: "
	inputNumber: 	.word 	0
	outputAnswer:	.word	0
	
.text
.globl main

# TODO: finish the app, for now the app gets the number and it write it to the console

main:
	jal askQuestion
	jal getInputFromUser
	move $a1, $v1
	jal writeInputFromUser
	
	j finishProgram

askQuestion:
	li $v0, 4
	la $a0, promptMessage
	syscall
	jr $ra

getInputFromUser:
	li $v0, 5
	syscall
	move $v1, $v0
	jr $ra
	
writeInputFromUser:
	li $v0, 1
	move $a0, $a1
	syscall
	jr $ra

finishProgram:
	li $v0,10
	syscall