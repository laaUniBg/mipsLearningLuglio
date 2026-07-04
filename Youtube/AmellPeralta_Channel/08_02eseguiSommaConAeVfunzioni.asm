.data
	primo: .word 10
	secondo: .word 20

.text
.globl main

# v0 e v1 sono return
# a0 e a1 sono arguments
main:
	jal leggiValoriDallaRam
	
	move $a0, $v0
	move $a1, $v1
	jal eseguiSomma
	
	move $a0, $v0
	jal printSomma
	
	j finishProgram

leggiValoriDallaRam:
	la $t0, primo
	lw $v0, 0($t0)
	la $t0, secondo
	lw $v1, 0($t0)
	jr $ra
	
eseguiSomma:
	add $v0, $a0, $a1
	jr $ra
	
printSomma:
	li $v0, 1 # 1 è codice int
	# non serve più un altro move, tanto lo faccio fuori
	syscall
	jr $ra
	
finishProgram:
	li $v0, 10
	syscall
