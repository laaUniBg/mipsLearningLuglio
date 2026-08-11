.data
	strArgIncorrectIndexStudent: .asciiz "il valore di indexStudent deve essere da 0 a 49"

	databaseErrorsKeyValue:
		.word ERROR_INCORRECT_INDEX_STUDENT, strArgIncorrectIndexStudent,
		.word NOT_FOUND, 0
.text