.eqv SIZE_INT      4
.eqv SIZE_STRING   20
.eqv SIZE_BOOLEAN  4

.data
    studentStructOffsets: .word 

.text



############
# @procedure initEmptyArrayOfSize
#   @param    {int}       $a0 - byteForEveryElement
#   @param    {int}       $a1 - sizeArray
#   @returns  {any[]}     $v0 - indirizzoArrayDinamico 
#   @modifies {$t0}           - 
############
initEmptyArrayOfSize:
    li $v0, 9
    mul $t0, $a0, $a1
    li $a0, $t0
    syscall
    jr $ra


# .eqv OFFSET_EXAM_CREDITS            0
# .eqv OFFSET_EXAM_GRADE              SIZE_INT        + OFFSET_EXAM_CREDITS 
# .eqv OFFSET_EXAM_NAME               SIZE_INT        + OFFSET_EXAM_GRADE
# .eqv SIZE_EXAM_STRUCT               SIZE_STRING     + OFFSET_EXAM_NAME

# .eqv OFFSET_STUD_ACTIVE             0
# .eqv OFFSET_STUD_ID                 SIZE_BOOLEAN    + OFFSET_STUD_ACTIVE 
# .eqv OFFSET_STUD_AGE                SIZE_INT        + OFFSET_STUD_ID
# .eqv OFFSET_STUD_YEAR               SIZE_INT        + OFFSET_STUD_AGE
# .eqv OFFSET_STUD_FIRSTNAME          SIZE_INT        + OFFSET_STUD_YEAR 
# .eqv OFFSET_STUD_LASTNAME           SIZE_STRING     + OFFSET_STUD_FIRSTNAME 
# .eqv OFFSET_STUD_NUM_PASSED_EXAMS   SIZE_STRING     + OFFSET_STUD_LASTNAME
# .eqv OFFSET_STUD_EXAMS_ARRAY        SIZE_INT        + OFFSET_STUD_NUM_PASSED_EXAMS

# .eqv MAX_EXAMS_EACH_STUDENT         20
# .eqv SIZE_EXAMS_ARRAY               MAX_EXAMS_EACH_STUDENT  * SIZE_EXAM_STRUCT
# .eqv SIZE_STUDENT_STRUCT            SIZE_EXAMS_ARRAY        + OFFSET_STUD_EXAMS_ARRAY

# .eqv MAX_STUDENTS_IN_ARRAY          50
# .eqv SIZE_STUDENTS_ARRAY            SIZE_STUDENT_STRUCT     * MAX_STUDENTS_IN_ARRAY

# .data
    
#     sizeStudenti: .word SIZE_STUDENTS_ARRAY
# .text


#     li $v0, 1
#     la $t0, sizeStudenti
#     lw $a0, 0($t0)
#     syscall