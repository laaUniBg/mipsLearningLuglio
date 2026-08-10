.eqv ERROR_INCORRECT_INDEX_STUDENT 1

.data
    strArgIncorrectIndexStudent: .asciiz "il valore di indexStudent deve essere da 0 a 49"

    databaseErrorsKeyValue:
        .word ERROR_INCORRECT_INDEX_STUDENT, strArgIncorrectIndexStudent,
        .word -1, 0
.text

# @arg {int} $a1 - thisErrorCodeNumber
searchInKeyValueMap:
    la $t0, databaseErrorsKeyValue # indirizzo database

lw $t1

