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

.data
	studentStructsArray: .space SIZE_STUDENTS_ARRAY

.text
	.globl main

main:
	j finishProgram

# @arg {addr.map} $a0 - mapAddress: una mappa nel nostro caso è un array di structs ovvero un array di strutture dati ordinate. 
# @arg {int} $a1 - sizeArrayItem
# @arg {int} $a2 - offsetKeyInsideItem
# @arg {bool} $a3 - isReturningfullSizeValue
# 					-> TRUE: ritornare indirizzo dell'item completo che comprende pure il key
#					-> FALSE: ritornare l'indirizzo dopo la fine del key (somma keyAddress+sizeAddress+arrayAddress)
# @arg ?{-1|int} $a4 - sizeBytesKey: (opzionale se vuoi indirizzo dell'item completo... invece se vuoi dopo il key devi inserire ovviamente anche questo argomento)
searchInKeyValueMap:

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


# 	li $a1, 20
# 	jal returnAddressStudentByIndex
# 	li $v0, 1
# 	move $a0, $v1
# 	syscall

# 	j finishProgram

# # @arg      {int}   $a1 - indexStudent (valore a 0 a 49)
# # @returns  {addr}  $v1 - offsetThisStudent (absolute con riferimento ram)
# # @modifies $t0, $t1
# returnAddressStudentByIndex:
# 	mul $t0, $a1, SIZE_STUDENT_STRUCT    # offsetThisStudente (relative)
# 	la $t1, studentStructsArray          # inizio posizione ram array studenti
# 	add $v1, $t0, $t1                    # offsetThisStudent (absolute)
#     jr $ra

# # @arg {int} $a1 - numeroCodiceErrore
# throwError:

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
