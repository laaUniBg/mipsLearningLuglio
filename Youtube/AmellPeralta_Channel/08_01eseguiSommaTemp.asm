.data
	primo: .word 10
	secondo: .word 20

.text
.globl main

main:
	jal leggiValoriDallaRam
	jal eseguiSomma
	jal printSomma
	j finishProgram

leggiValoriDallaRam:
	la $t0, primo
	lw $t1, 0($t0)
	la $t0, secondo
	lw $t2, 0($t0)
	jr $ra
	
eseguiSomma:
	add $t0, $t1, $t2
	jr $ra
	
printSomma:
	li $v0, 1 # 1 è codice int
	move $a0, $t0	
	syscall
	jr $ra
	
finishProgram:
	li $v0, 10
	syscall