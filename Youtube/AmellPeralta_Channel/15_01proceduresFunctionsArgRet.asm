.data

.text
.globl main

# procedure is function (like c++/js)
main:
	li $a1, 50
	li $a2, 100	
	
	jal addNumbers
	
	li $v0, 1
	move $a0, $v1
	syscall
	
	j finishProgram

addNumbers:
	add $v1, $a1, $a2
	jr $ra
	
finishProgram:
	li $v0, 10
	syscall
