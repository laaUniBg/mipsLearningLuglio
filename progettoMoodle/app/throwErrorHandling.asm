	.eqv ERROR_INCORRECT_INDEX_STUDENT 1
	.eqv CONST_UNO 1
.data
	strArgIncorrectIndexStudent: .asciiz "il valore di indexStudent deve essere da 0 a 49"

	databaseErrorsKeyValue:
		.word ERROR_INCORRECT_INDEX_STUDENT, strArgIncorrectIndexStudent,
		.word -1, 0
.text

# INIZIO searchInKeyValueMap
# @arg {int}        $a1 - thisKey
# @arg {addr|int}   $a2 - thisMap (solo .word maps {key: int, value: addr} -> il value è indirizzo di una stringa .asciiz)
searchInKeyValueMap:
    # salvo $ra per poter chiamare le funzioni dentro le funzioni
    addi $sp, $sp, -4
    sw $ra, 0($sp)

	la $t0, $a2    # indirizzo inizio database

searchLoop:
	lw $t1, 0($t0)                      # thisKey
	seq $t2, $t1, $a1                   # isFound

	beq $t2, CONST_UNO, isFoundLogic    # if(isFound)
	beq $t2, $zero, isNotFoundLogic     # if(!isFound)

isFoundLogic:
	lw $t3, 4($t0)    # indirizzoValueString

    move $a1, $t3
    jal printStringFromAddress

	j finallyLogic

isNotFoundLogic:
	j finallyLogic

finallyLogic:
    lw $ra, 0($sp)
    addi $sp, $sp, 4

	jr $ra
# FINE searchInKeyValueMap
