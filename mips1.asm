.data
	myMessage: .asciiz "Hello world \n"

.text
	li $v0,4 #system please print out a text
	la $a0, myMessage # what text? myMessage, ok I will load it in the register
	syscall # now you have all the info, do it now
	
	
