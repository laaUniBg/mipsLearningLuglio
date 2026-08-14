.eqv MAX_EXAMS_EACH_STUDENT 20
.eqv MAX_STUDENTS_IN_ARRAY 50

.eqv OFFSET_STUD_ID 0
.eqv OFFSET_STUD_ACTIVE 4
.eqv OFFSET_STUD_AGE 8
.eqv OFFSET_STUD_YEAR 12
.eqv OFFSET_STUD_FIRSTNAME 16
.eqv OFFSET_STUD_LASTNAME 36
.eqv OFFSET_STUD_NUM_PASSED_EXAMS 56
.eqv OFFSET_STUD_EXAMS_ARRAY 60

.eqv OFFSET_EXAM_CREDITS 0
.eqv OFFSET_EXAM_GRADE 4
.eqv OFFSET_EXAM_NAME 8
.eqv SIZE_EXAM_STRUCT 28

.eqv SIZE_EXAMS_ARRAY 560 # 20*28
.eqv SIZE_STUDENT_STRUCT 620 # 560+60
.eqv SIZE_STUDENTS_ARRAY 31000 # 620*50

.eqv TRUE       1
.eqv FALSE      0
.eqv NOT_FOUND  -1

.data
	studentStructsArray: .space SIZE_STUDENTS_ARRAY

.text
	.globl main

main:
	j finishProgram

# @arg {addr.string} $a1 - firstString
# @arg {addr.string} $a2 - secondString
# @returns {int} $v1 - ritorna 0 se uguale, ritorna valore negativo se alfabeticamente firstString precede secondString, ritorna valore positivo se alfabeticamente firstString succede secondString.
# @modifies {addr.char} $t0 - firstString char Address
# @modifies {addr.char} $t1 - secondString char Address
# @modifies {int.asciiCharCode} $t2 - firstString char asciiByteCode (il carattere viene trasformato in numero)
# @modifies {int.asciiCharCode} $t3 - secondString char asciiByteCode (il carattere viene trasformato in numero)
# @modifies {int.asciiCharCode} $t4 - firstString char asciiByteCode (ma se nella ricerca si trova \0, $t4 diventa il char precedente cosi ci facilita il ritorno della differenza)
# @modifies {int.asciiCharCode} $t5 - secondString char asciiByteCode (ma se nella ricerca si trova \0, $t4 diventa il char precedente cosi ci facilita il ritorno della differenza)
# @modifies {int} $t6 - è la differenza ovvero il valore di return se char diversi tra str1 e str2
strCompare:
	move $t0, $a1 # charAddressFirstString
	move $t1, $a2 # charAddressSecondString
	
	strCompare__innerLoop:
		lb $t2, 0($t0) # thisChar ASCIIbyteCode FirstString
		lb $t3, 0($t1) # thisChar ASCIIbyteCode SecondString

		beq $t2, $t3, strCompare__isCharEqualLogic
			strCompare__isCharNotEqualLogic:
				beq $t2, $zero, strCompare__firstStringSetCharToPrevious
					strCompare__firstStringSetCharToCurrent:
						lb $t4, 0($t0)
						j strCompare__firstStringSetCharFinally

					strCompare__firstStringSetCharToPrevious:
						lb $t4, -1($t0) # il carattere prima di \0 cosi non facciamo sottrazione con \0
						j strCompare__firstStringSetCharFinally

					strCompare__firstStringSetCharFinally:
						beq $t3, $zero, strCompare__secondStringSetCharToPrevious
							strCompare__secondStringSetCharToCurrent:
								lb $t5, 0($t1)
								j strCompare__secondStringSetCharFinally

							strCompare__secondStringSetCharToPrevious:
								lb $t5, -1($t1)
								j strCompare__secondStringSetCharFinally

							strCompare__secondStringSetCharFinally:
								sub $t6, $t4, $t5 # differenza: è il valore di return effettivo se char diversi
								move $v1, $t6
								j strCompare__finallyLogic

			strCompare__isCharEqualLogic:
				beq $t2, $zero, strCompare__bothEqualStringFinishedLogic # controllo stringa finita: basta e avanza solo un controllo (visto che sappiamo che sono uguali)
					strCompare__stillLoopingLogic:
						addi $t0, $t0, 1 # firstString nextChar address
						addi $t1, $t1, 1 # secondString nextChar address
						j strCompare__innerLoop

					strCompare__bothEqualStringFinishedLogic:
						move $v1, $zero # $zero significa uguali
						j strCompare__finallyLogic

	strCompare__finallyLogic:
		jr $ra

# @arg {addr.arrayOfStructs} $a0 - arrayOfStructsAddress: una mappa nel nostro caso è un array di structs ovvero un array di strutture dati ordinate. (io generalmente parto da $a1 per gli argomento per evitare di sovrascrivere syscall methods ma quindi ho bisogno di tanti argomenti quindi parto da 0... quindi ricorda che se modifichi il codice e aggiungi qualche syscall di salvarla nello stack momentaneamente per evitare bugs)
# @arg {int} $t8 - sizeOfArrayOfStructs: serve per decidere quando fermarsi nella ricerca per ritornare il NOT_FOUND ovvero -1
# @arg {int} $a1 - sizeArrayItem
# @arg {int} $a2 - offsetKeyInsideItem (diamo per scontato che il key sia una word ovvero un integer quindi sizeBytesOfKey = 4)
# @arg {int} $a3 - integerToSearch (se trovato poi ritorna la posizione dell'item struct dove è presente il key)
# @returns {addr.struct} $v1 - ritorna la posizione address dell'item dove è presente il key
# @modifies {addr.struct} $t0 - thisItemAddress
# @modifies {addr.int} $t1 - thisKeyAddress
# @modifies {int} $t2 - thisKey (non indirizzo ma valore)
# @modifies {addr.struct} $t3 - nextItemAddress (serve per il controllo prima di aggiornare $t0)
# @modifies {addr} $t4 - maxAddressPossible
searchInKeyIntegerValueMap:
	move $t0, $a0 # thisItemAddress (ovviamente all'inizio combaccia con l'indirizzo dell'array)

	searchInKeyIntegerValueMap__innerSearchLoop:
		addu $t1, $t0, $a2 # thisKeyAddress (ovvero utilizzo offset studente e dentro lo struct student aggiungo offset del key)
		lw $t2, 0($t1) # thisKey (non indirizzo ma valore)

		beq $t2, $a3, searchInKeyIntegerValueMap__isKeyFoundLogic
			searchInKeyIntegerValueMap__isStillSearchingLogic:
				addu $t3, $t0, $a1 # nextItemAddress
				addu $t4, $a0, $t8 # maxAddressPossible
				bge $t3, $t4, searchInKeyIntegerValueMap__isKeyNotFoundLogic # if(nextItemAddress>sizeOfArray) allora è sicuro che non devo continuare la ricerca se no accedo a un altra variabile (quindi abbiamo controllato tutto l'array)
				move $t0, $t3 # aggiorno thisItemAddress con nextItemAddress
				j searchInKeyIntegerValueMap__innerSearchLoop

			searchInKeyIntegerValueMap__isKeyFoundLogic:
				move $v1, $t0
				j searchInKeyIntegerValueMap__finallyLogic

			searchInKeyIntegerValueMap__isKeyNotFoundLogic:
				move $v1, NOT_FOUND
				j searchInKeyIntegerValueMap__finallyLogic
	
	searchInKeyIntegerValueMap__finallyLogic:
		jr $ra

# @arg {int} $a1 - wantedIndex
# @arg {int} $a2 - sizeOfItem
# @arg {addr.array} $a3 - arrayAddress
# @returns {addr.any} $v1 - addressAtIndex
# @modiefies {int} $t0 - arrayOffset
getAddressOfItemOfArrayUsingSizeAndIndex:
	mul $t0, $a1, $a2 # arrayOffset
	add $v1, $a3, $t0 # return addressAtIndex
	jr $ra

# @arg {int} $a1 - wantedIndex
# @returns {addr.array} $v1 - addressAtIndex 
getAddressOfStudentUsingIndex:
	stackPreserveStart($ra)
	li $a2, SIZE_STUDENT_STRUCT
	la $a3, studentStructsArray
	jal getAddressOfItemOfArrayUsingSizeAndIndex
	stackPreserveEnd($ra)
	jr $ra

# @arg {addr} $a1 - indirizzoStringaDaPrintare
printStringFromAddress:
    li $v0, 4
    move $a0, $a1
    syscall
    jr $ra


# # @arg      {int}   $a1 - indexStudent (valore a 0 a 49)
# # @returns  {addr}  $v1 - offsetThisStudent (absolute con riferimento ram)
# # @modifies $t0, $t1
# returnAddressStudentByIndex:
# 	mul $t0, $a1, SIZE_STUDENT_STRUCT    # offsetThisStudente (relative)
# 	la $t1, studentStructsArray          # inizio posizione ram array studenti
# 	add $v1, $t0, $t1                    # offsetThisStudent (absolute)
#     jr $ra

.macro stackPreserveStart(%registerToSave)
    addi $sp, $sp, -4
    sw %registerToSave, 0($sp)
.end_macro

.macro stackPreserveEnd(%registerToLoad)
    lw %registerToLoad, 0($sp)
    addi $sp, $sp, 4
.end_macro

finishProgram:
	li $v0, 10
	syscall
