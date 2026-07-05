.data
	
.text
.globl main

# TODO

main:
	j finishProgram
	
finishProgram:
	li $v0, 10
	syscall
