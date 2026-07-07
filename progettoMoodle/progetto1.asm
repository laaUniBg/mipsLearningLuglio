.data
	arrayStudentId:			.space 200  	# 50 studenti, 4 byte (word)
	arrayAge: 				.space 200  
	arrayYearOfEnrollment:  .space 200
	arrayNumberPassedExams: .space 200
	arrayStatus: 			.space 200

	arrayFirstName: 		.space 1000 	# 19 char, 50 studenti
	arrayLastName: 			.space 1000
	
	arrayExamCredits: 		.space 4000		# 50 studenti, 20 esami, 4 byte (word)
	arrayExamGrades: 		.space 4000		

	arrayExamNames: 		.space 20000 	# 50 studenti, 20 esami, 19 char
.text