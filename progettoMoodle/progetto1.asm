.eqv WORDSIZE 4
.eqv STRINGLENGTH 20

.data
	# STUDENT DATA
	arrayStudentId:			.space 200  	# 50 studenti, 4 byte (word)
	arrayAge: 				.space 200  
	arrayYearEnrollment:  	.space 200
	arrayNumberPassedExams: .space 200
	arrayStatus: 			.space 200

	arrayFirstName: 		.space 1000 	# 19 char, 50 studenti
	arrayLastName: 			.space 1000
	
	# EXAM DATA
	arrayExamCredits: 		.space 4000		# 50 studenti, 20 esami, 4 byte (word)
	arrayExamGrades: 		.space 4000		

	arrayExamNames: 		.space 20000 	# 50 studenti, 20 esami, 19 char

	indexLastStudent: 		.word 0

	# STUDENT QUESTION STRINGS
	strQuestionFirstName:		.asciiz "scrivi nome studente: "
	strQuestionLastName:		.asciiz "scrivi cognome studente: "
	strQuestionAge: 			.asciiz "scrivi l'eta  studente: "
	strQuestionYearEnrollment: 	.asciiz "scrivi anno di iscrizione: "
	strQuestionStudentId: 		.asciiz "scrivi l'id dello studente: "
	strNewLine: 				.asciiz "\n"
	strAnswerGenericInput: 	.asciiz "il valore di input è: "
.text
.globl main

main:
	jal insertNewStudent
	j finishProgram


insertNewStudent:
	subi $sp, $sp, WORDSIZE
	sw $ra, 0($sp)
	
	# nome
	la $a2, strQuestionFirstName
	jal	printString
	
	la $a2, arrayFirstName
	jal returnThisStudentStringAddress
	
	move $a2, $v1
	jal getInputString
	
	
	# cognome
	la $a2, strQuestionLastName
	jal printString
	
	la $a2, arrayLastName
	jal returnThisStudentStringAddress
	
	move $a2, $v1
	jal getInputString
	
	# eta
	la $a2, strQuestionAge
	jal printString
	
	la $a2, arrayAge
	jal returnThisStudentIntegerAddress
	
	move $a2, $v1
	jal getInputInteger

	# year
	la $a2, strQuestionYearEnrollment
	jal printString
	
	la $a2, arrayYearEnrollment
	jal returnThisStudentIntegerAddress
	
	move $a2, $v1
	jal getInputInteger
	
	# id
	la $a2, strQuestionStudentId
	jal printString
	
	la $a2, arrayStudentId
	jal returnThisStudentIntegerAddress
	
	move $a2, $v1
	jal getInputInteger

	# incrementa
	la $a2, indexLastStudent
	jal incrementCounterFromIntegerAdress

	lw $ra, 0($sp)
	addi $sp, $sp, WORDSIZE

	jr $ra
	
# $a2: indirizzoWord
returnThisStudentIntegerAddress:
	la $t0, indexLastStudent
	lw $t1, 0($t0)				# $t1: indexLastStudent
	
	mul $t2, $t1, WORDSIZE		# $t2: OFFSET = indexLastStudent * 4
	add $t3, $a2, $t2			# $t3: intArr[i] = indirizzo array + offset
	
	move $v1, $t3				# return $t3: indirizzo word nell'array
	
	jr $ra
	

# $a2: indirizzoArrayString
# $v1: indirizzoStringa nell'array
returnThisStudentStringAddress:
	la $t0, indexLastStudent
	lw $t1, 0($t0)				# indexLastStudent
	
	mul $t2, $t1, STRINGLENGTH	# $t2: OFFSET = indexLastStudent * 20
	add $t3, $a2, $t2			# $t3: indirizzo che vogliamo = indirizzo stringa + OFFSET
	
	move $v1, $t3				# return $t3: indirizzo che vogliamo
	
	jr $ra

# $a2: indirizzoWordDaIncrementare
# $v1: valoreWordIncrementato
incrementCounterFromIntegerAdress:
	lw $t1, 0($a2)
	addi $t1, $t1, 1
	sw $t1, 0($a2)
	
	move $v1, $t1
	jr $ra

# $a2: indirizzo stringa da printare
printString:
	li $v0, 4
	move $a0, $a2
	syscall
	jr $ra
	
# $a2: indirizzoStringa
printGenericAnswerString:
	subi $sp, $sp, WORDSIZE
	sw $ra, 0($sp)
	
	move $t0, $a2
	
	la $a2, strAnswerGenericInput
	jal printString
	
	li $v0, 4
	move $a2, $t0
	move $a0, $a2
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, WORDSIZE
	
	jr $ra

# $a2: integer value (non indirizzo ma value diretto)
printGenericAnswerIntegerValue:
	subi $sp, $sp, WORDSIZE
	sw $ra, 0($sp)
	
	move $t0, $a2
	
	la $a2, strAnswerGenericInput
	jal printString
	
	move $a2, $t0
	
	li $v0, 1
	move $a0, $a2
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, WORDSIZE
	
	jr $ra

# $a2: indirizzo stringa
# $v1: stringa input ottenuta
getInputString:
	subi $sp, $sp, WORDSIZE
	sw $ra, 0($sp)
	
	li $v0, 8
	move $a0, $a2			# scrittura stringa già in ram
	li $a1, STRINGLENGTH
	syscall
	
	move $t0, $a2
	la $a2, strNewLine
	jal printString
	
	move $a2, $t0
	move $v1, $a2
	jal printGenericAnswerString
	
	la $a2, strNewLine
	jal printString
	
	lw $ra, 0($sp)
	addi $sp, $sp, WORDSIZE
	
	jr $ra

# $a2: indirizzo integer
# $v1: integer input value ottenuta
getInputInteger:
	subi $sp, $sp, WORDSIZE
	sw $ra, 0($sp)
	
	li $v0, 5
	syscall
	sw $v0, 0($a2)
	
	move $t0, $v0
	la $a2, strNewLine
	jal printString
	
	move $v1, $t0	
	move $a2, $v1
	jal printGenericAnswerIntegerValue
	
	la $a2, strNewLine
	jal printString
	
	lw $ra, 0($sp)
	addi $sp, $sp, WORDSIZE
	
	jr $ra

finishProgram:
	li $v0, 10
	syscall
