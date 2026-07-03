.data
	thisChar: .byte 'A'
	
	
.text
	li $v0, 11 # 11 è printChar
	lb $a0, thisChar # lb, lh, lw si usano per ritornare il valore direttamente perchè sappiamo già la dimensione 
	#non usiamo commando 'la' perchè ritornerebbe l'indirizzo puntatore all'inizio. utile sinceramente solo nelle stringhe .asciiz
	syscall
	j fineProgramma
	
fineProgramma:
	li $v0, 10 # fineProgramma
	syscall