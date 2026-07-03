.data
	thisInt: .word 999

.text
.globl main

main:
	li $v0, 1 # print int è codice 1
	lw $a0, thisInt
	syscall
	j exit
	
	
exit:
	li $v0, 10
	syscall
