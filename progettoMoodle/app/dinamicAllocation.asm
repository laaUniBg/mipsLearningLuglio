.data

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
