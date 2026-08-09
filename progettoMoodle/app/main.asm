	.eqv SIZE_INT 4
	.eqv SIZE_STRING 20 # multiplo di 4, evito problema allineamento
	.eqv SIZE_BOOLEAN 4 # 1 byte basta e avanza però per praticità uso 4 come un int per evitare problemi sull'allineamento
    .eqv MAX_EXAMS_EACH_STUDENT 20

.data
	studentStruct:
		SIZE_BOOLEAN,   #isActive
		SIZE_INT,       #id
		SIZE_INT,       #age
		SIZE_INT,       #yearEnrollment
		SIZE_STRING,    #firstName
		SIZE_STRING,    #lastName
		SIZE_INT,       #numberPassedExams

	examStruct:
		SIZE_INT,       #credits
        SIZE_INT,       #grade
        SIZE_STRING,    #examName

    thisStudent:
        #sizeOfStudentStruct + (sizeOfExamStruct * 20)

.text


.text
	.globl main

main:
	j finishProgram

initStudentArray:
	jal initEmptyArrayOfSize
	jr $ra

finishProgram:
	li $v0, 10
	syscall
