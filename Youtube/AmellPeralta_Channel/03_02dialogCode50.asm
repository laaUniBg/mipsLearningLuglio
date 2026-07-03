.data
	myMessage: .asciiz "Hello world \n"
	mesSi: .asciiz "siii \n"
	mesNo: .asciiz "noooo \n"
	mesAnnulla: .asciiz "hai annullatooooo \n"

.text
	li $v0,50 # I want a dialog
	la $a0, myMessage # question: 0 SI, 1 NO, 2 CANCEL
	syscall
	
	li $v0, 4 # print function is 4
	
	beq $a0, 0, gotoSi
	beq $a0, 1, gotoNo
	beq $a0, 2, gotoAnnulla

gotoSi:
	la $a0, mesSi
	syscall
	j fineProgramma
	
gotoNo:
	la $a0 mesNo
	syscall
	j fineProgramma

gotoAnnulla:
	la $a0 mesAnnulla
	syscall
	j fineProgramma
	
fineProgramma:
	li $v0, 10 #exit programma
	syscall
	j fineProgramma
	
