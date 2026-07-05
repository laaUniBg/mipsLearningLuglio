.data
	message: .asciiz "Hi everybody. \nmy name is Anas."
.text
.globl main

# procedure is function (like c++/js)

main:
	jal displayMessage
	
	j finishProgram


displayMessage:
	li $v0, 4
	la $a0, message
	syscall
	jr $ra
	
finishProgram:
	li $v0, 10
	syscall
