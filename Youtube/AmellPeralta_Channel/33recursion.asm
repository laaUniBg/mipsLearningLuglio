.data
	promptMessage: 	.asciiz "enter a number to find its factorial: "
	resultMessage: 	.asciiz "\nThe factorial of the number is: "
	inputNumber: 	.word 	0
	outputNumber:	.word	0
	
.text
.globl main
.globl findFactorial

# TODO: finish the app, for now the app gets the number and it write it to the console

main:
	la $a1, promptMessage
	jal writeString
	
	jal getInputFromUser
	
	# input $a1: inputNumber	(n)
	# output $v1: outputNumber 	(answer)
	la $t0, inputNumber
	
	lw $a1, 0($t0)
	jal findFactorial
	
	la $t0, outputNumber
	sw $v1, 0($t0)
	
	la $a1, resultMessage
	jal writeString
	
	move $a1, $v1
	jal writeNumber
	
	j finishProgram
	
findFactorial:
	jr $ra
	
writeString:
	li $v0, 4
	move $a0, $a1
	syscall
	jr $ra

getInputFromUser:
	li $v0, 5
	syscall
	move $v1, $v0
	jr $ra

writeNumber:
	li $v0, 1
	move $a0, $a1
	syscall
	jr $ra

finishProgram:
	li $v0,10
	syscall