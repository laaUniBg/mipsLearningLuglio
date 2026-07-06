.data

.text
.globl main

main:
	li $a1, 0
	j WHILE1_START
WHILE1_END:
	li $v0, 1
	move $a0, $a1
	syscall
	j finishProgram
	
############# procedures

WHILE1_START:
	slti $t0, $a1, 10 # isLessThanTen
	beq $t0, 1, WHILE1_CONTENT
	j WHILE1_END
	
WHILE1_CONTENT:
	addi $a1, $a1, 1
	j WHILE1_START

finishProgram:
	li $v0, 10
	syscall