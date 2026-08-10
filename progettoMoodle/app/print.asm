.data

.text
.globl printStringFromAddress

# @arg {addr} $a1 - indirizzoStringaDaPrintare
printStringFromAddress:
    li $v0, 4
    move $a0, $a1
    syscall
    jr $ra
