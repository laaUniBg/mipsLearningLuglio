.data

.text
.globl main

main:
	li $s0, 67
	li $s1, 666
	
	jal aggiungi30
	
	li $v0, 10
	syscall
	
aggiungi30:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	
	addi $s0, $s0, 30
	addi $s1, $s1, 30
	
	li $v0, 1
	move $a0, $s0
	syscall
	move $a0, $s1
	syscall
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8

	jr $ra