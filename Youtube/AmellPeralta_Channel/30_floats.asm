.data
	first: .float 10.64
	second: .float 10.47
.text
.globl main

main:
	la $t0, first
	lwc1 $f4, 0($t0)
	
	la $t0, second
	lwc1 $f6, 0($t0)
	
	add.s $f8, $f4, $f6
	
	li $v0, 2
	mov.s $f12, $f8
	syscall
	
	j finishProgram
	
############# procedures

finishProgram:
	li $v0, 10
	syscall