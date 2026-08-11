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


finishProgram:
	li $v0, 10
	syscall
