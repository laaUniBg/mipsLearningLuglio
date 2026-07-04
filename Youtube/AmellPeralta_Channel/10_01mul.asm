.data

.text
.globl main

main:
	
	j exit
	
exit:
	li $v0, 10
	syscall