.data
	strEqual: .asciiz "the numbers are equal."
	strNotEqual: .asciiz "nothing happened"

.text
.globl main

main:
	li $t0, 10
	li $t1, 10
	beq $t0, $t1, printEqual
	j printNotEqual
ENDIF1:
	j finishProgram

printEqual:
	li $v0, 4
	la $a0, strEqual
	syscall
	j ENDIF1
	
printNotEqual:
	li $v0, 4
	la $a0, strNotEqual
	syscall
	j ENDIF1

finishProgram:
	li $v0, 10
	syscall