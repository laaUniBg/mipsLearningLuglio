.data
	thisChar: .byte 'A'
	
.text
	li $v0, 4 # meglio 11 dai docs però un carattere è una parte di stringa se ci pensi
	la $a0, thisChar # se usi il codice 11 allora devi usare 'lb' al posto di 'la' perchè codice 11 non vuole l'indirizzo ma il valore ascii direttamente
	syscall
	j fineProgramma
	
fineProgramma:
	li $v0, 10 # fineProgramma
	syscall