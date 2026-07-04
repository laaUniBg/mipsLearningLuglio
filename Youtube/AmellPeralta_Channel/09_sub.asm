.data
	number1: .word 20
	number2: .word 8
	
.text
.globl main

main:
	la $t0, number1
	lw $s0, 0($t0)
	la $t0, number2
	lw $s1, 0($t0)
	
	sub $t0, $s0, $s1
	
	li $v0, 1
	move $a0, $t0
	syscall