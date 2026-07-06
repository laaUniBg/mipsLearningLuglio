.data
	# myArray: .space 12 # 12/4=3 words
	myArray: .word 10,20,30,40
	enterStr: .asciiz "\n"
.text
.globl main

# TODO RISOLVI ERRORE COMPILAZIONE: 
# 20
# 40
# 60
# 80
# 80

main:
	li $a1, 0 					# initilize index
	li $v1, 0					# thisSomma
	
	j LOOP1START
LOOP1EXIT:
	li $v0, 1
	move $a0, $v1
	syscall
	
	j finishProgram
	
############# procedures

LOOP1START:
	bge $a1, 4, LOOP1EXIT 		# if(index>=4) exit();
	
	addi $a1, $a1, 1 			# thisIndex
	
	la $t2, myArray
	add $t2, $t2, 4 			# thisAddress
	
	lw $t3, 0($t2)				# thisValue
	
	add $v1, $v1, $t3			# thisSomma
	
	li $v0, 1
	move $a0, $v1
	syscall
	
	li $v0, 4
	la $a0, enterStr
	syscall
	
	
	j LOOP1START

finishProgram:
	li $v0, 10
	syscall