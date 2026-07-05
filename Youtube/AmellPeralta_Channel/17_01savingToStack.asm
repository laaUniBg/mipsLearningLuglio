.data
	newLine: .asciiz "\n"
.text
.globl main

main:
	li $s0, 10
	
	jal increaseMyRegister
	jal printNewLine
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	j finishProgram
	
finishProgram:
	li $v0, 10
	syscall
	
increaseMyRegister:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $ra, 4($sp) # se uso una sottofunzione devo salvare $ra perche jal sovrascrive $ra subito
	
	addi $s0, $s0, 30
	li $v0, 1
	move $a0, $s0
	syscall
	
	jal printNewLine
	
	lw $s0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	jr $ra
	
printNewLine:
	li $v0, 4
	la $a0, newLine
	syscall
	jr $ra