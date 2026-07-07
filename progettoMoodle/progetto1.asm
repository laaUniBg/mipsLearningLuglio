.eqv WORDSIZE 4
.eqv STRINGLENGTH 20

.data
	# STUDENT DATA
	arrayStudentId:			.space 200  	# 50 studenti, 4 byte (word)
	arrayAge: 				.space 200  
	arrayYearOfEnrollment:  .space 200
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
	strQuestionAge: 			.asciiz "scrivi l'età studente: "
	strQuestionYearEnrollment: 	.asciiz "scrivi anno di iscrizione: "
	strQuestionStudentId: 		.asciiz "scrivi l'id dello studente: "
.text
.globl main

main:

	j finishProgram


insertNewStudent:
	subi $sp, $sp, WORDSIZE
	sw $ra, 0($sp)

	la $a2, strQuestionFirstName
	jal	printString
	la $a2, arrayFirstName
	jal returnThisStudentStringAddress

	la $a2, strQuestionLastName
	jal printString
	la $a2, arrayLastName
	jal returnThisStudentStringAddress

	la $a2, strQuestionAge
	jal printString,
	la $a2, arrayAge

	la $a2, strQuestionYearEnrollment
	jal printString
	la $a2, arrayYearEnrollment

	la $a2, strQuestionStudentId
	jal printString
	la $a2, arrayStudentId

	lw $a2, indexLastStudent
	jal incrementCounter

	lw $ra, 0($sp)
	addi $sp, $sp, WORDSIZE

	jr $ra

# $a2: indirizzoArrayString
returnThisStudentStringAddress:
	subi $sp, $sp, WORDSIZE
	sw $ra, 0($sp)
	
	la $t0, indexLastStudent
	lw $t1, 0($t0)				# indexLastStudent
	
	mul $t2, $t1, STRINGLENGTH	# indexLastStudent * 20 = OFFSET
	addi $t3, $a2, $v1			# indirizzo stringa + OFFSET = indirizzo che vogliamo
	
	move $v1, $t3
	
	lw $ra, 0($sp)
	addi $sp, $sp, WORDSIZE
	
	jr $ra

# $a2: indirizzoWordDaIncrementare
# $v1: valoreWordIncrementato
incrementCounter:
	move $t0, $a2
	lw $t1, 0($t0)
	addi $t1, $t1, 1
	sw $t1, 0($t0)
	move $v1, $t1
	jr $ra

# $a2: indirizzo stringa da printare
printString:
	li $v0, 4
	move $a0, $a2
	syscall
	jr $ra

# $a2: indirizzo stringa
# $v1: stringa input ottenuta
getInputString:
	li $v0, 8
	
	move $a0, $a2
	li $a1, STRINGLENGTH
	
	syscall
	
	move $v1, $v0
	jr $ra

# $a2: indirizzo integer
# $v1: integer input ottenuta
getInputInteger:
	li $v0, 5
	move $a0, $a2
	syscall
	move $v1, $v0
	jr $ra

finishProgram:
	li $v0, 10
	syscall
