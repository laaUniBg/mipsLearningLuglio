.data

.text
	li $s0, 67
	li $s1, 666
	
	jal aggiungi30
	
	li $v0, 10
	syscall
	
aggiungi30:
	subi $sp, $sp, 4
	sw $s0, 0($sp)
	
	addi $s0, $s0, 30
	li $v0, 1
	move $a0, $s0
	syscall
	
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	
	subi $sp, $sp, 4
	sw $s1, 0($sp)
	
	addi $s1, $s1, 30
	li $v0, 1
	move $a0, $s1
	
	lw $s1, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
	
	
	
	

	
