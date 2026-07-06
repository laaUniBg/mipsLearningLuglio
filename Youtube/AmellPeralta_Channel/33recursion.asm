.data
	promptMessage: 	.asciiz "enter a number to find its factorial: "
	resultMessage: 	.asciiz "\nThe factorial of the number is: "
	inputNumber: 	.word 	0
	outputNumber:	.word	0
	
.text
.globl main
.globl findFactorial

# TODO: finish the app, for now is not working, only printing ONE but i will try to solve it

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
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	li $v1, 1
	# base case
	beq $a1, $zero, factorialDone   # if (n == 0) return 1
	
	move $s0, $a1 # prendi argomento e lo salvi in $s0
	sub $a1, $a1, 1 # n-1 e lo passo come parametro
	jal findFactorial

	mul $v1, $s0, $v1 # return v*fact

factorialDone:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addi $sp, $sp, 8
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
	
