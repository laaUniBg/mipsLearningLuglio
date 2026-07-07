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
	addi $sp, $sp, -4
	sw $ra, 0(sp)

	la $a2, strQuestionFirstName
	jal	printString

	la $a2, strQuestionLastName
	jal printString

	la $a2, strQuestionAge
	jal printString

	la $a2, strQuestionYearEnrollment
	jal printString

	la $a2, strQuestionStudentId
	jal printString

	lw $a2, indexLastStudent
	jal incrementCounter

	lw $ra, 0(sp)
	addi $sp, $sp, 4

	jr $ra

# $a2: indirizzoWordDaIncrementare
incrementCounter:
	la $t0, $a2
	lw $t1, 0($t0)
	addi $t1, $t1, 1
	move $v1, $t1
	sw $v1, 0($t0)
	jr $ra

# $a2: indirizzo stringa da printare
printString:
	li $v0, 4
	move $a0, $a2
	syscall
	jr $ra

# $a2: indirizzo stringa nella ram da scriverci su
readString20char:
	li $v0, 8
	move $a0, $a2
	move $a1, 20
	syscall
	move $v1, $v0
	jr $ra

# $a2: indirizzo integer
readInteger:
	li $v0, 5
	move $a0, $a2
	syscall
	move $v1, $v0
	jr $ra

finishProgram:
	li $v0, 10
	syscall
