.data
	promptMessage: 	.asciiz "enter a number to find its factorial: "
	resultMessage: 	.asciiz "\nThe factorial of the number is: "
	
.text
.globl main
.globl findFactorial

# TODO: finish the app, for now is not working, only printing ONE but i will try to solve it

main:
	la $a1, promptMessage
	jal writeString
	
	jal getInputFromUser
	
	# call first time with $a1 = n
	move $a1, $v1
	jal findFactorial
	
	la $a1, resultMessage
	jal writeString
	
	move $a1, $v1
	jal writeNumber
	
	j finishProgram

findFactorial:
	# save to stack $ra, $s0
	# $s0 is n
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	beq $a1, $zero, casoBase  # if (n == 0) return 1
	
	move $s0, $a1 # n di stack = n argomento
	sub $a1, $a1, 1 # passo come argomento n-1
	jal findFactorial

	mul $v1, $s0, $v1 # factReturn = n*factReturn
	j factorialDone

casoBase:
	li $v1, 1

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
	
