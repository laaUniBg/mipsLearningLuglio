.data
	thisInt: .word 999

.text
.globl main

main:
	li $v0, 1 # print int è codice 1
	la $t0, thisInt
	lw $a0, 0($t0)
	syscall
	j exit
	
	
exit:
	li $v0, 10
	syscall
