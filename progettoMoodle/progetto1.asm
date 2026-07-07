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
	la $a1, strQuestionFirstName
	jal	printString
	

	la $a1, strQuestionLastName
	jal printString

	la $a1, strQuestionAge
	jal printString

	la $a1, strQuestionYearEnrollment
	jal printString

	la $a1, strQuestionStudentId
	jal printString

	la $a1
	jr $ra


printString:
	li $v0, 4
	move $a0, $a1
	move $v1, $v0
	syscall
	jr $ra

finishProgram:
	li $v0, 10
	syscall
